using System.Collections.Generic;

namespace ORB.Core.Models
{
    public partial class AttributeType : Entity
    {
        public AttributeType()
        {
            Attributes = new HashSet<ORB.Core.Models.Attribute>();
        }

        public bool? Display { get; set; }

        public virtual ICollection<ORB.Core.Models.Attribute> Attributes { get; set; }
    }
}
