using System;
using System.Runtime.Serialization;

namespace ORB.Core
{
    [Serializable]
    public class AuthorizationException : System.Exception, ISerializable
    {
        protected AuthorizationException(SerializationInfo info, StreamingContext context)
            : base(info, context)
        {
        }

        public AuthorizationException() : base() { }

        public AuthorizationException(string message) : base(message) { }

        public AuthorizationException(string message, Exception innerException) : base(message, innerException) { }

        public override void GetObjectData(SerializationInfo info, StreamingContext context)
        {
            base.GetObjectData(info, context);
        }
    }

}