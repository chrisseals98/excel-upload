using Microsoft.EntityFrameworkCore;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Text.Json.Serialization;

namespace DO_POC.Server.Models
{
    [Table("Samples"), PrimaryKey(nameof(SampleNumber), nameof(LocId))]
    public class Sample
    {
        [Required, Column("SAMPLE_NUMBER")]
        public string SampleNumber { get; set; }

        [Column("SAMPLE_DEPTH")]
        public float Depth { get; set; }

        [Column("SAMPLE_TIME")]
        public DateTime DateTime { get; set; }

        [Required, Column("LOC_ID"), ForeignKey(nameof(Location))]
        public string LocId { get; set; }

        [JsonIgnore]
        public Location Location { get; set; }

        public ICollection<Result> Results { get; set; }

    }
}
