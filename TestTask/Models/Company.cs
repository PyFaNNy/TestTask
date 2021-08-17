using System.ComponentModel.DataAnnotations;

namespace TestTask.Models
{
    /// <summary>
    /// Entity сompany
    /// </summary>
    public class Company
    {
        [Required]
        public int Id { get; set; }
        public int Size { get; set; }
        [Required]
        public string Name { get; set; }
        [Required]
        public string OrganizationalLegalForm { get; set; }

    }
}
