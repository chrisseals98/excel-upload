using DO_POC.Server.Models;
using Microsoft.EntityFrameworkCore;

namespace DO_POC.Server.Services
{
    public class DBRepository : IDBRepository
    {
        private AppDBContext _db;

        public DBRepository(AppDBContext db)
        {
            this._db = db;
        }

        public List<Location> ReadAllLocations()
        {
            return this._db.Locations.ToList();
        }

        public List<Sample> ReadAllSamples()
        {
            return this._db.Samples
                .Include(s => s.Location)
                .Include(s => s.Results)
                .ToList();
        }

        public List<Result> ReadAllResults()
        {
            return this._db.Results
                .Include(r => r.Sample)
                .ThenInclude(s => s.Location)
                .ToList();
        }

        public int AddSamples(List<Sample> samples)
        {
            try
            {
                this._db.Samples.AddRange(samples);
                return this._db.SaveChanges();
            }
            catch (Exception e)
            {
                throw e;
            }
        }
    }
}
