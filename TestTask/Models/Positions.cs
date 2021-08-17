using System.ComponentModel;
using System.ComponentModel.DataAnnotations;

namespace TestTask.Models
{
    /// <summary>
    /// Enum to enumerate the possible positions
    /// </summary>
    public enum Positions
    {
        [Display(Name = "Junior Developer")]
        JuniorDeveloper,
        [Display(Name = "Middle Developer")]
        MiddleDeveloper,
        [Display(Name = "Senior Developer")]
        SeniorDeveloper,
        [Display(Name = "Junior QA")]
        JuniorQA,
        [Display(Name = "Middle QA")]
        MiddleQA,
        [Display(Name = "Senior QA")]
        SeniorQA,
        [Display(Name = "Project Manager")]
        ProjectManager,
        [Display(Name = "Software Architect")]
        SoftwareArchitect,
        [Display(Name = "Team Lead")]
        TeamLead,
        [Display(Name = "Tech Lead")]
        TechLead,
    }
}
