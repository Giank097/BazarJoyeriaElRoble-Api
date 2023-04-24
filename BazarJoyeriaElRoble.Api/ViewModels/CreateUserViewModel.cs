using BazarJoyeriaElRoble.Infrastructure;
using System.ComponentModel.DataAnnotations;

namespace BazarJoyeriaElRoble.Api.ViewModels
{
    public class CreateUserViewModel
    {
        public int Id { get; set; }

        public string Email { get; set; } = null!;

        public string Password { get; set; } = null!;

        public string FirstName { get; set; } = null!;

        public string LastName { get; set; } = null!;

        public int Phone { get; set; }

        public string? Address { get; set; }

        public string Rol { get; set; } = null!;

    }
}
