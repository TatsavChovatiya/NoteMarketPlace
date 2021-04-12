using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace NotesMarketplace.Models
{
    public partial class DummyUser
    {
        public int P_K_User { get; set; }
        public int F_K_UserRoles { get; set; }

        [Display(Name = "first name")]
        [Required]
        [RegularExpression("^[a-zA-Z]*$", ErrorMessage = "Enter valid name")]
        public string FirstName { get; set; }

        [Required]
        [Display(Name = "last name")]
        [RegularExpression("^[a-zA-Z]*$", ErrorMessage = "Enter valid name")]
        public string LastName { get; set; }

        [Required]
        [Display(Name = "Email address")]
        [EmailAddress]
        public string EmailId { get; set; }

        [Required]
        [Display(Name = "password")]
        [MinLength(6, ErrorMessage = "Requird Minimum length 6")]
        // [RegularExpression(@"^(?=.[a-z])(?=.\d)(?=.[@$!%?&])(\\S)[A-Za-z\d@$!%?&]{6,24}$", ErrorMessage = "Password must be strong")]
        public string Password { get; set; }

        [Required]
        [Compare("Password")]
        [Display(Name = "confirm password")]
        public string Password2 { get; set; }

        public bool IsEmailVerified { get; set; }
        public bool IsDetailsSubmitted { get; set; }
        public bool RememberMe { get; set; }
        public Nullable<System.DateTime> CreaatedDate { get; set; }
        public Nullable<int> CreatedBy { get; set; }
        public Nullable<System.DateTime> ModifiedDate { get; set; }
        public Nullable<int> ModifiedBy { get; set; }
        public bool IsActive { get; set; }

    }
}