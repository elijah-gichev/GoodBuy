namespace GoodBuy.Models
{
    public class GoodbuyDatabaseSettings : IGoodbuyDatabaseSettings
    {
        public string ReviewsCollectionName { get; set; }
        public string ConnectionString { get; set; }
        public string DatabaseName { get; set; }
    }

    public interface IGoodbuyDatabaseSettings
    {
        string ReviewsCollectionName { get; set; }
        string ConnectionString { get; set; }
        string DatabaseName { get; set; }
    }

}
