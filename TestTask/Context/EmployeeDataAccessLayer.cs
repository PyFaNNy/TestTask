using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using TestTask.Models;

namespace TestTask.Context
{
    /// <summary>
    /// Сlass for interacting with the table of Employees
    /// </summary>
    public class EmployeeDataAccessLayer
    {
        string ConnectionString = Context.ConnectionString.CName;
        /// <summary>
        /// Accessing the database for a list of employees
        /// </summary>
        /// <param name="sortOrder">Sorting method for received data</param>
        public IEnumerable<Employee> GetAllEmployees(SortState sortOder= SortState.Id)
        {
            List<Employee> lstEmployee = new List<Employee>();
            using (SqlConnection con = new SqlConnection(ConnectionString))
            {
                SqlCommand cmd = new SqlCommand("spGetEmployee"+sortOder.ToString(), con);
                cmd.CommandType = CommandType.StoredProcedure;
                con.Open();
                SqlDataReader rdr = cmd.ExecuteReader();

                while (rdr.Read())
                {
                    Employee employee = new Employee();
                    employee.Id = Convert.ToInt32(rdr["Id"]);
                    employee.FirstName = rdr["FirstName"].ToString();
                    employee.LastName = rdr["LastName"].ToString();
                    employee.MiddleName = rdr["MiddleName"].ToString();
                    employee.Company = rdr["Company"].ToString();
                    Enum.TryParse(rdr["Position"].ToString(), out Positions position);
                    employee.Position = position;
                    employee.EmploymentDate =Convert.ToDateTime(rdr["EmploymentDate"]);

                    lstEmployee.Add(employee);
                }
                con.Close();
            }
            return lstEmployee;
        }
        /// <summary>
        /// Accessing the database to calculate the number of employees in the company
        /// </summary>
        /// <param name="companyName">Name of the company</param>
        public int CountEmployees(string companyName)
        {
            int count = 0;
            using (SqlConnection con = new SqlConnection(ConnectionString))
            {
                SqlCommand cmd = new SqlCommand("spCountEmployee", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@CompanyName", companyName);
                con.Open();
                SqlDataReader rdr = cmd.ExecuteReader();

                while (rdr.Read())
                {
                    count = Convert.ToInt32(rdr[""]);
                }
                con.Close();
            }
            return count;
        }
        /// <summary>
        /// Accessing the database to add a employee
        /// </summary>
        /// <param name="employee">Employee instance to be add into the database</param>
        public void AddEmployee(Employee employee)
        {
            using (SqlConnection con = new SqlConnection(ConnectionString))
            {
                SqlCommand cmd = new SqlCommand("spAddEmployee", con);
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@FirstName", employee.FirstName);
                cmd.Parameters.AddWithValue("@LastName", employee.LastName);
                cmd.Parameters.AddWithValue("@MiddleName", employee.MiddleName);
                cmd.Parameters.AddWithValue("@Company", employee.Company);
                cmd.Parameters.AddWithValue("@Position", employee.Position);
                cmd.Parameters.AddWithValue("@Date", employee.EmploymentDate);
                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();
            }
        }
        /// <summary>
        /// Accessing the database to delete a employee
        /// </summary>
        /// <param name="id">Id of the employee</param>
        public void DeleteEmployee(int? id)
        {
            using (SqlConnection con = new SqlConnection(ConnectionString))
            {
                SqlCommand cmd = new SqlCommand("spDeleteEmployee", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@Id", id);
                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();
            }
        }
        /// <summary>
        /// Accessing the database to update a employee
        /// </summary>
        /// <param name="employee">Employee instance to be updated into the database</param>
        public void UpdateEmployee(Employee employee)
        {
            using (SqlConnection con = new SqlConnection(ConnectionString))
            {
                SqlCommand cmd = new SqlCommand("spUpdateEmployee", con);
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@Id", employee.Id);
                cmd.Parameters.AddWithValue("@FirstName", employee.FirstName);
                cmd.Parameters.AddWithValue("@LastName", employee.LastName);
                cmd.Parameters.AddWithValue("@MiddleName", employee.MiddleName);
                cmd.Parameters.AddWithValue("@Company", employee.Company);
                cmd.Parameters.AddWithValue("@Position", employee.Position);
                cmd.Parameters.AddWithValue("@EmploymentDate", employee.EmploymentDate);
                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();
            }
        }
        /// <summary>
        /// Accessing the database to get a employee
        /// </summary>
        /// <param name="id">Id of the employee</param>
        public Employee GetEmployeeData(int id)
        {
            Employee employee = new Employee();

            using (SqlConnection con = new SqlConnection(ConnectionString))
            {
                string sqlQuery = $"SELECT * FROM Employee WHERE Id = " + id;
                SqlCommand cmd = new SqlCommand(sqlQuery, con);
                con.Open();
                SqlDataReader rdr = cmd.ExecuteReader();

                while (rdr.Read())
                {
                    employee.Id = Convert.ToInt32(rdr["Id"]);
                    employee.FirstName = rdr["FirstName"].ToString();
                    employee.LastName = rdr["LastName"].ToString();
                    employee.MiddleName = rdr["MiddleName"].ToString();
                    employee.Company = rdr["Company"].ToString();
                    Enum.TryParse(rdr["Position"].ToString(), out Positions position);
                    employee.Position = position;
                    employee.EmploymentDate = Convert.ToDateTime(rdr["EmploymentDate"]);
                }
            }
            return employee;
        }
    }
}
