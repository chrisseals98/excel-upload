using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace DO_POC.Server.Models
{
    [Table("Locations")]
    public class Location
    {
        [Key, Column("LOC_ID")]
        public string LocId { get; set; }

        [Column("STATE")]
        public string State { get; set; }
        
        [Column("MAX_DEPTH")]
        public float MaxDepth { get; set; }
    }
}
