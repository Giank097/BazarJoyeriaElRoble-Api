using BazarJoyeriaElRoble.Api.ViewModels;
using BazarJoyeriaElRoble.Infrastructure;
using BazarJoyeriaElRoble.Infrastructure.Data.Context;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using System;

// For more information on enabling Web API for empty projects, visit https://go.microsoft.com/fwlink/?LinkID=397860

namespace BazarJoyeriaElRoble.Api.Controllers
{
    [Route("api/users")]
    [ApiController]
    public class UsersController : ControllerBase
    {
        // ================================================================================================================================================
        private readonly DbBazarJoyeriaElRobleContext context;
        // ================================================================================================================================================
        public UsersController(DbBazarJoyeriaElRobleContext context)
        {
            this.context = context;
        }
        // ================================================================================================================================================
        // GET: api/<UsersController>
        [HttpGet("get_all")]
        public ActionResult<IEnumerable<UserViewModel>> Get()
        {
            var usersList = context.TbUsers.Where(u => u.DeletedAt == null);
           if (usersList is not null)
           {
                var usersList2 = new List<UserViewModel>();

                foreach (var user in usersList)
                {
                    usersList2.Add(new UserViewModel { Id = user.Id, Email = user.Email, FirstName = user.FirstName, LastName = user.LastName, Phone = user.Phone, Address = user.Address });
                };

                return Ok(usersList2.AsEnumerable());

           }
           else
           {
                return NotFound("There is not users yet :(, let's create one! :D");
           }
        }
        // ================================================================================================================================================
        // GET api/<UsersController>/5
        [HttpGet("get/{id}")]
        public ActionResult<UserViewModel> Get(int id)
        {
            var user = context.TbUsers.Where(e => e.Id == id && e.DeletedAt == null).SingleOrDefault();

            if(user is not null)
            {
                UserViewModel user2 = new ()
                { 
                    Id = user.Id,
                    Email = user.Email,
                    FirstName= user.FirstName,
                    LastName= user.LastName,
                    Phone= user.Phone,
                    Address= user.Address
                };
                
                return Ok(user2);
            }
            else
            {
                return NotFound("The user you have requested for does not exist or it has been removed :/");
            }

        }
        // ================================================================================================================================================
        // POST api/<UsersController>
        [HttpPost("create")]
        public IActionResult Post([FromBody] CreateUserViewModel user)
        {
            TbUser newUser = new()
            {
                Id = user.Id,
                Email = user.Email,
                Password = user.Password,
                FirstName = user.FirstName,
                LastName = user.LastName,
                Phone = user.Phone,
                Address = user.Address,
                Rol = user.Rol,
                CreatedAt = DateTime.Now
            };

            try
            {
                context.TbUsers.Add(newUser);
                context.SaveChanges();

                return Ok();
            }
            catch (Exception)
            {

                return BadRequest("Something went wrong while saving user in the database x_x");
            }


        }
        // ================================================================================================================================================
        // PUT api/<UsersController>/5
        [HttpPut("update/{id}")]
        public IActionResult Put(int id, [FromBody] UpdateUserViewModel user)
        {
            var ExistingUser = context.TbUsers.Find(id);

            if(ExistingUser is not null)
            {
                ExistingUser.Email = user.Email;
                ExistingUser.Password = user.Password;
                ExistingUser.FirstName = user.FirstName;
                ExistingUser.LastName = user.LastName;
                ExistingUser.Phone = user.Phone;
                ExistingUser.Address = user.Address;
                ExistingUser.Rol = user.Rol;
                ExistingUser.ModifiedAt = DateTime.Now;

                context.TbUsers.Update(ExistingUser);
                context.SaveChanges();

                return Ok(user);
            }
            else
            {
                return NotFound("The user that you want to update does not exist or it has been removed :S");

            }



        }
        // ================================================================================================================================================
        // DELETE api/<UsersController>/5
        [HttpPut("delete/{id}")]
        public IActionResult Delete(int id)
        {
            var userToDelete = context.TbUsers.Where(u => u.Id == id && u.DeletedAt == null).SingleOrDefault();
            
            if(userToDelete is not null)
            {
                userToDelete.DeletedAt = DateTime.Now;

                return Ok((context.TbUsers.Update(userToDelete), context.SaveChanges()));
            }
            else
            {
                return NotFound("The user that you want to delete does not exist or it has already been deleted >:#");
            }
        }
        // ================================================================================================================================================
    }
}
