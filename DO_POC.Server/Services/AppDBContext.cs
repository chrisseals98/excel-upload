using DO_POC.Server.Models;
using Microsoft.EntityFrameworkCore;

namespace DO_POC.Server.Services
{
    public class AppDBContext(DbContextOptions options) : DbContext(options)
    {
        public DbSet<Sample> Samples { get; set; }
        public DbSet<Result> Results { get; set; }
        public DbSet<Location> Locations { get; set; }
    }
}
