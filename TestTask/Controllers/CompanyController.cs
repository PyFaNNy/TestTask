using Microsoft.AspNetCore.Mvc;
using System.Collections.Generic;
using TestTask.Context;
using TestTask.Models;

namespace TestTask.Controllers
{

    /// <summary>
    /// The controller that interacts with the Model.Company
    /// </summary>
    public class CompanyController : Controller
    {
        EmployeeDataAccessLayer EmployeeDataAccessLayer = null;
        CompanyDataAccessLayer CompanyDataAccessLayer = null;
        public CompanyController()
        {
            EmployeeDataAccessLayer = new EmployeeDataAccessLayer();
            CompanyDataAccessLayer = new CompanyDataAccessLayer();
        }
        /// <summary>
        /// Get request for getting a list of companies.
        /// </summary>
        /// <param name="sortOrder">Sorting method for received data</param>
        [HttpGet]
        public ActionResult Index(SortState sortOrder=SortState.Id)
        {
            ViewData["IdSort"] = sortOrder == SortState.Id ? SortState.IdDesc : SortState.Id;
            ViewData["NameSort"] = sortOrder == SortState.Name ? SortState.NameDesc : SortState.Name;
            ViewData["OrganizationalLegalFormSort"] = sortOrder == SortState.OrganizationalLegalForm ? SortState.OrganizationalLegalFormDesc : SortState.OrganizationalLegalForm;

            IEnumerable<Company> companies = CompanyDataAccessLayer.GetAllCompanies(sortOrder);
            return View(companies);
        }
        /// <summary>
        /// Get request for create a company.
        /// </summary>
        [HttpGet]
        public ActionResult Create()
        {
            return View();
        }
        /// <summary>
        /// Post request for create a company.
        /// </summary>
        /// <param name="company">Data to be entered into the database</param>
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create(Company company)
        {
            try
            {
                CompanyDataAccessLayer.AddCompany(company);
                return RedirectToAction(nameof(Index));
            }
            catch
            {
                return View();
            }
        }
        /// <summary>
        /// Get request for edit a company.
        /// </summary>
        /// <param name="companyName">To search the database for a record</param>
        [HttpGet]
        public ActionResult Edit(string companyName)
        {
            ViewBag.Company = CompanyDataAccessLayer.GetCompanyData(companyName);
            return View();
        }
        /// <summary>
        /// Post request for edit a company.
        /// </summary>
        /// <param name="company">Data to be entered into the database</param>
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit(Company company)
        {
            try
            {
                CompanyDataAccessLayer.UpdateCompany(company);
                return RedirectToAction(nameof(Index));
            }
            catch
            {
                return RedirectToAction("Edit", "Company", new { companyName = company.Name });
            }
        }
        /// <summary>
        /// Post request for delete a companies.
        /// </summary>
        /// <param name="selectedCompany">Array of id companies to remove</param>
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Delete(int[] selectedCompany)
        {
            try
            {
                foreach (var id in selectedCompany)
                {
                    CompanyDataAccessLayer.DeleteCompany(id);
                }

                return RedirectToAction(nameof(Index));
            }
            catch
            {
                return RedirectToAction(nameof(Index));
            }
        }
    }
}
