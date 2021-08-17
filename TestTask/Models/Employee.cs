using System;
using System.ComponentModel.DataAnnotations;

namespace TestTask.Models
{
    /// <summary>
    /// Entity employee
    /// </summary>
    public class Employee
    {
        [Required]
        public int Id { get; set; }
        [Required]
        public string LastName { get; set; }
        [Required]
        public string FirstName { get; set; }
        [Required]
        public string MiddleName { get; set; }
        [Required]
        public Positions Position { get; set; }
        [Required]
        public string Company { get; set; }
        [Required]
        public DateTime EmploymentDate { get; set; }

    }
}
