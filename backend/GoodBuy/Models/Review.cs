using System;
using MongoDB.Bson;
using MongoDB.Bson.Serialization.Attributes;

namespace GoodBuy.Models
{
    public class Review
    {
        [BsonId]
        [BsonRepresentation(BsonType.ObjectId)]
        public string Id { get; set; }

        [BsonElement("Name")]
        public string Name { get; set; }
        public string QrCode { get; set; }

        [BsonDateTimeOptions(Kind = DateTimeKind.Local)]
        public DateTime DateAdded { get; set; }
    }
}
