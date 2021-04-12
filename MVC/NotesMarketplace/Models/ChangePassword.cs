using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace NotesMarketplace.Models
{
    public class ChangePassword
    {
        [Required]
        [Display(Name = "old password")]
        [MinLength(6, ErrorMessage = "Requird Minimum length 6")]
        // [RegularExpression(@"^(?=.[a-z])(?=.\d)(?=.[@$!%?&])(\\S)[A-Za-z\d@$!%?&]{6,24}$", ErrorMessage = "Password must be strong")]
        public string OldPassword { get; set; }

        [Required]
        [Display(Name = "new password")]
        [MinLength(6, ErrorMessage = "Requird Minimum length 6")]
        // [RegularExpression(@"^(?=.[a-z])(?=.\d)(?=.[@$!%?&])(\\S)[A-Za-z\d@$!%?&]{6,24}$", ErrorMessage = "Password must be strong")]
        public string Password { get; set; }

        [Required]
        [Compare("Password")]
        [Display(Name = "confirm password")]
        public string Password2 { get; set; }
    }
}