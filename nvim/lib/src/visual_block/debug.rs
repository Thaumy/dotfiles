use std::fmt::Debug;

pub struct DebugChar(char);

impl Debug for DebugChar {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        f.write_str(&self.0.to_string())?;
        Ok(())
    }
}

impl From<&u8> for DebugChar {
    fn from(value: &u8) -> Self {
        Self(*value as char)
    }
}
