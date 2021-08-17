using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using System;
using System.Collections.Generic;
using TestTask.Context;
using TestTask.Models;

namespace TestTask.Controllers
{

    /// <summary>
    /// The controller that interacts with the Model.Employee
    /// </summary>
    public class EmployeeController : Controller
    {
        EmployeeDataAccessLayer EmployeeDataAccessLayer = null;
        CompanyDataAccessLayer CompanyDataAccessLayer = null;
        public EmployeeController()
        {
            EmployeeDataAccessLayer = new EmployeeDataAccessLayer();
            CompanyDataAccessLayer = new CompanyDataAccessLayer();
        }
        /// <summary>
        /// Get request for getting a list of employees.
        /// </summary>
        /// <param name="sortOrder">Sorting method for received data</param>
        [HttpGet]
        public ActionResult Index(SortState sortOrder = SortState.Id)
        {
            ViewData["IdSort"] = sortOrder == SortState.Id ? SortState.IdDesc : SortState.Id;
            ViewData["NameSort"] = sortOrder == SortState.Name ? SortState.NameDesc : SortState.Name;
            ViewData["LastNameSort"] = sortOrder == SortState.LastName ? SortState.LastNameDesc : SortState.LastName;
            ViewData["MiddleNameSort"] = sortOrder == SortState.MiddleName ? SortState.MiddleNameDesc : SortState.MiddleName;
            ViewData["PositionSort"] = sortOrder == SortState.Position ? SortState.PositionDesc : SortState.Position;
            ViewData["CompanySort"] = sortOrder == SortState.Company ? SortState.CompanyDesc : SortState.Company;
            ViewData["EmploymentDateSort"] = sortOrder == SortState.EmploymentDate ? SortState.EmploymentDateDesc : SortState.EmploymentDate;

            IEnumerable<Employee> employees = EmployeeDataAccessLayer.GetAllEmployees(sortOrder);
            return View(employees);
        }
        /// <summary>
        /// Get request for create a employee.
        /// </summary>
        [HttpGet]
        public ActionResult Create()
        {
            IEnumerable<Company> companies = CompanyDataAccessLayer.GetAllCompanies();
            ViewBag.Companies = new SelectList(companies, "Name", "Name");
            return View();
        }
        /// <summary>
        /// Post request for create a employee.
        /// </summary>
        /// <param name="employee">Data to be entered into the database</param>
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create(Employee employee)
        {
            try
            {
                EmployeeDataAccessLayer.AddEmployee(employee);
                return RedirectToAction(nameof(Index));
            }
            catch (Exception ex)
            {
                return View();
            }
        }
        /// <summary>
        /// Get request for edit a employee.
        /// </summary>
        /// <param name="id">To search the database for a record</param>
        [HttpGet]
        public ActionResult Edit(int id)
        {
            IEnumerable<Company> companies = CompanyDataAccessLayer.GetAllCompanies();
            ViewBag.Companies = new SelectList(companies, "Name", "Name");
            ViewBag.Employee = EmployeeDataAccessLayer.GetEmployeeData(id);
            return View();
        }
        /// <summary>
        /// Post request for edit a company.
        /// </summary>
        /// <param name="employee">Data to be entered into the database</param>
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit(Employee employee)
        {
            try
            {
                EmployeeDataAccessLayer.UpdateEmployee(employee);
                return RedirectToAction(nameof(Index));
            }
            catch
            {
                return RedirectToAction("Edit", "Employee", new { id = employee.Id });
            }
        }
        /// <summary>
        /// Post request for delete a companies.
        /// </summary>
        /// <param name="selectedCompany">Array of id companies to remove</param>
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Delete(int[] selectedEmployee)
        {
            try
            {
                foreach (var id in selectedEmployee)
                {
                    EmployeeDataAccessLayer.DeleteEmployee(id);
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
