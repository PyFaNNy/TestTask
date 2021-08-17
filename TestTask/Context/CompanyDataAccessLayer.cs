using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using TestTask.Models;

namespace TestTask.Context
{
    /// <summary>
    /// Сlass for interacting with the table of Company
    /// </summary>
    public class CompanyDataAccessLayer
    {
        string ConnectionString = Context.ConnectionString.CName;
        /// <summary>
        /// Accessing the database for a list of companies
        /// </summary>
        /// <param name="sortOrder">Sorting method for received data</param>
        public IEnumerable<Company> GetAllCompanies(SortState sortOrder = SortState.Id)
        {
            List<Company> lstCompany = new List<Company>();
            EmployeeDataAccessLayer employeeDataAccessLayer = new EmployeeDataAccessLayer();
            using (SqlConnection con = new SqlConnection(ConnectionString))
            {
                SqlCommand cmd = new SqlCommand("spGetCompany"+sortOrder.ToString(), con);
                cmd.CommandType = CommandType.StoredProcedure;
                con.Open();
                SqlDataReader rdr = cmd.ExecuteReader();

                while (rdr.Read())
                {
                    Company company = new Company();
                    company.Id = Convert.ToInt32(rdr["Id"]);
                    company.Name = rdr["Name"].ToString();
                    company.OrganizationalLegalForm = rdr["OrganizationalLegalForm"].ToString();
                    company.Size = employeeDataAccessLayer.CountEmployees(company.Name);

                    lstCompany.Add(company);
                }
                con.Close();
            }
            return lstCompany;
        }
        /// <summary>
        /// Accessing the database to add a company
        /// </summary>
        /// <param name="employee">Company instance to be entered into the database</param>
        public void AddCompany(Company employee)
        {
            using (SqlConnection con = new SqlConnection(ConnectionString))
            {
                SqlCommand cmd = new SqlCommand("spAddCompany", con);
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@Name", employee.Name);
                cmd.Parameters.AddWithValue("@OrganizationalLegalForm", employee.OrganizationalLegalForm);
                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();
            }
        }
        /// <summary>
        /// Accessing the database to delete a company
        /// </summary>
        /// <param name="id">Id of the company</param>
        public void DeleteCompany(int? id)
        {
            using (SqlConnection con = new SqlConnection(ConnectionString))
            {
                SqlCommand cmd = new SqlCommand("spDeleteCompany", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@Id", id);
                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();
            }
        }
        /// <summary>
        /// Accessing the database to update a company
        /// </summary>
        /// <param name="employee">Company instance to be updated into the database</param>
        public void UpdateCompany(Company company)
        {
            using (SqlConnection con = new SqlConnection(ConnectionString))
            {
                SqlCommand cmd = new SqlCommand("spUpdateCompany", con);
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@Id", company.Id);
                cmd.Parameters.AddWithValue("@Name", company.Name);
                cmd.Parameters.AddWithValue("@OrganizationalLegalForm", company.OrganizationalLegalForm);
                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();
            }
        }
        /// <summary>
        /// Accessing the database to get a company
        /// </summary>
        /// <param name="companyName">Name of the company</param>
        public Company GetCompanyData(string companyName)
        {
            Company company = new Company();

            using (SqlConnection con = new SqlConnection(ConnectionString))
            {
                string sqlQuery = $"SELECT * FROM Company WHERE Name = '{companyName}'";
                SqlCommand cmd = new SqlCommand(sqlQuery, con);
                con.Open();
                SqlDataReader rdr = cmd.ExecuteReader();

                while (rdr.Read())
                {
                    company.Id = Convert.ToInt32(rdr["Id"]);
                    company.Name = rdr["Name"].ToString();
                    company.OrganizationalLegalForm = rdr["OrganizationalLegalForm"].ToString();
                }
            }
            return company;
        }
    }
}
