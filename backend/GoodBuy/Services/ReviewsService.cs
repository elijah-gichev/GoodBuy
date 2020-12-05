using GoodBuy.Models;
using MongoDB.Driver;
using System.Collections.Generic;
using System.Linq;

namespace GoodBuy.Services
{
    public class ReviewsService
    {
        private readonly IMongoCollection<Review> _review;

        public ReviewsService(IGoodbuyDatabaseSettings settings)
        {
            var client = new MongoClient(settings.ConnectionString);
            var database = client.GetDatabase(settings.DatabaseName);

            _review = database.GetCollection<Review>(settings.ReviewsCollectionName);
        }

        public List<Review> Get() =>
            _review.Find(review => true).ToList();

        public Review Get(string qrCode) =>
            _review.Find<Review>(review => review.QrCode == qrCode).FirstOrDefault();

        public Review Create(Review review)
        {
            _review.InsertOne(review);
            return review;
        }

        public void Update(string id, Review reviewIn) =>
            _review.ReplaceOne(review => review.Id == id, reviewIn);

        public void Remove(Review reviewIn) =>
            _review.DeleteOne(review => review.Id == reviewIn.Id);

        public void Remove(string id) =>
            _review.DeleteOne(review => review.Id == id);
    }

}
