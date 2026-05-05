use std::ptr;
use std::sync::atomic::{AtomicBool, Ordering};

use tokio::runtime::{Builder, Runtime};
use zbus::{Connection, Error, Proxy};

pub struct ImSwitch {
    rt: Runtime,
    proxy: Proxy<'static>,
    busy: AtomicBool,
    activate_next: bool,
}

#[unsafe(no_mangle)]
pub extern "C" fn im_switch_new() -> *mut ImSwitch {
    let Ok(rt) = Builder::new_multi_thread().enable_all().build() else {
        return ptr::null_mut();
    };
    let Ok(proxy) = rt.block_on(async {
        Proxy::new(
            &Connection::session().await?,
            "org.fcitx.Fcitx5",
            "/controller",
            "org.fcitx.Fcitx.Controller1",
        )
        .await
    }) else {
        return ptr::null_mut();
    };

    Box::into_raw(Box::new(ImSwitch {
        rt,
        proxy,
        busy: AtomicBool::new(false),
        activate_next: false,
    }))
}

#[expect(clippy::missing_safety_doc)]
#[unsafe(no_mangle)]
pub unsafe extern "C" fn im_switch_activate(im_sw: *mut ImSwitch) {
    let im_sw = unsafe { &mut *im_sw };

    if im_sw.busy.swap(true, Ordering::AcqRel) {
        return;
    }

    if !im_sw.activate_next {
        im_sw.busy.store(false, Ordering::Release);
        return;
    }

    im_sw.rt.spawn(async {
        let _ = async {
            im_sw.proxy.call_method("Activate", &()).await?;
            Ok::<_, Error>(())
        }
        .await;
        im_sw.busy.store(false, Ordering::Release);
    });
}

#[expect(clippy::missing_safety_doc)]
#[unsafe(no_mangle)]
pub unsafe extern "C" fn im_switch_deactivate(im_sw: *mut ImSwitch) {
    let im_sw = unsafe { &mut *im_sw };

    if im_sw.busy.swap(true, Ordering::AcqRel) {
        return;
    }

    im_sw.rt.spawn(async {
        let _ = async {
            let message = im_sw.proxy.call_method("State", &()).await?;
            let state: i32 = message.body().deserialize()?;
            if state == 2 {
                im_sw.proxy.call_method("Deactivate", &()).await?;
                im_sw.activate_next = true;
            } else {
                im_sw.activate_next = false;
            }
            Ok::<_, Error>(())
        }
        .await;
        im_sw.busy.store(false, Ordering::Release);
    });
}
