using System;
using MongoDB.Driver;

namespace mongo
{
    class Program
    {
        static void Main(string[] args)
        {
            var settings = new MongoClientSettings()
            {
                Server = new MongoServerAddress("mongo", 27017),
                ConnectTimeout = new TimeSpan(0, 0, 1),
            };
            var client = new MongoClient(settings);
            var db = client.GetDatabase("HeavyLoad");
            var collection = db.GetCollection<LoadData>("LoadData");
            Console.WriteLine(settings.Server);

            int number = 0;
            while (true)
            {
                var now = DateTime.UtcNow;
                var data = new LoadData
                {
                    Date = now,
                    Number = number++
                };

                try
                {
                    collection.InsertOne(data);
                    Console.WriteLine($"inserted {number} at {now:yyyy-MM-dd hh:mm:ss.fff}");
                }
                catch (System.Exception ex)
                {
                    Console.WriteLine($"Insertion of Number {number} failed at {now:yyyy-MM-dd hh:mm:ss.fff} because {ex.Message}");
                }
            }

            Console.WriteLine("finished");
        }
    }
}
