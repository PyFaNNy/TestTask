namespace TestTask.Context
{
    /// <summary>
    /// Сlass for storing the connection string
    /// </summary>
    public static class ConnectionString
    {
        private static string cName = @"Data Source=HOME-PC\SQLEXPRESS;Initial Catalog=TestDB;Integrated Security=True";
        public static string CName
        {
            get => cName;
        }
    }
}
