namespace ORB.Core.ReportViewModels
{
    public abstract class AttributeViewModel
    {
        public int AttributeTypeID { get; set; }
        public string AttributeValue { get; set; }

        public AttributeTypeViewModel AttributeType { get; set; }
    }
}
