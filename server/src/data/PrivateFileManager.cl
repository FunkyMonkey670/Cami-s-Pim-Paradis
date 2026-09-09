extension PrivateFileManager
{
    _storageFileName = "";

    function SetupStorage(fileName)
    {
        if (fileName != null && PersistentData.IsValidFileName(fileName)) {self._storageFileName = fileName;}
    }

    function LoadFileName(storageProperty, encrypted, serialized)
    {
        if (self._storageFileName == "" || storageProperty == null || storageProperty == "") {return null;}
        value = PData.LoadDataFromFile(self._storageFileName, storageProperty, encrypted, serialized);
        if (value == null || value == "")
        {
            value = "Pim_" + storageProperty;
            PData.SaveToFile(self._storageFileName, storageProperty, value, encrypted, false);
        }
        return value;
    }
}
