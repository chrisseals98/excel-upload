using Microsoft.EntityFrameworkCore;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Text.Json.Serialization;

namespace DO_POC.Server.Models
{
    [Table("Results"), PrimaryKey(nameof(SampleNumber), nameof(ResultName), nameof(LocId))]
    public class Result
    {
        [Required, Column("SAMPLE_NUMBER")]
        public string SampleNumber { get; set; }

        [Required, Column("RESULT_NAME")]
        public string ResultName { get; set; }

        [Column("VALUE")]
        public double Value { get; set; }

        [Required, Column("LOC_ID")]
        public string LocId { get; set; }

        [ForeignKey($"{nameof(SampleNumber)},{nameof(LocId)}"), JsonIgnore]
        public Sample Sample { get; set; }
    }
}
