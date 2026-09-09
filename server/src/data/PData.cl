extension PData
{
    function IsValid(fileName, propertyName)
    {
        return fileName != null && propertyName != null && propertyName != "" && PersistentData.IsValidFileName(fileName);
    }

    function SaveToFile(fileName, propertyName, data, encrypted, serialized)
    {
        if (!self.IsValid(fileName, propertyName)) {return false;}
        PersistentData.Clear();
        if (PersistentData.FileExists(fileName)) {PersistentData.LoadFromFile(fileName, encrypted);}
        value = data;
        if (serialized) {value = Json.SaveToString(data);}
        PersistentData.SetProperty(propertyName, value);
        PersistentData.SaveToFile(fileName, encrypted);
        PersistentData.Clear();
        return true;
    }

    function TryLoadDataFromFile(fileName, propertyName, defaultValue, encrypted, serialized)
    {
        if (!self.IsValid(fileName, propertyName)) {return null;}
        if (!PersistentData.FileExists(fileName))
        {
            self.SaveToFile(fileName, propertyName, defaultValue, encrypted, serialized);
            return defaultValue;
        }
        loaded = self.LoadDataFromFile(fileName, propertyName, encrypted, serialized);
        if (loaded == null) {return defaultValue;}
        return loaded;
    }

    function LoadDataFromFile(fileName, propertyName, encrypted, serialized)
    {
        if (!self.IsValid(fileName, propertyName) || !PersistentData.FileExists(fileName)) {return null;}
        PersistentData.Clear();
        PersistentData.LoadFromFile(fileName, encrypted);
        value = PersistentData.GetProperty(propertyName, null);
        PersistentData.Clear();
        if (!serialized) {return value;}
        if (value == null || value == "") {return null;}
        return Json.LoadFromString(value);
    }
}
