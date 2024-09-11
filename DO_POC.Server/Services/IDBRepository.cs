using DO_POC.Server.Models;

namespace DO_POC.Server.Services
{
    public interface IDBRepository
    {
        List<Location> ReadAllLocations();
        List<Sample> ReadAllSamples();
        List<Result> ReadAllResults();
        int AddSamples(List<Sample> samples);
    }
}
