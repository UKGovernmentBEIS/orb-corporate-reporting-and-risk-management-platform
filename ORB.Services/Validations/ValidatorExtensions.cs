using FluentValidation;
using ORB.Core.Models;
using System;
using System.Collections.Generic;
using System.Text;

namespace ORB.Services.Validations
{
    public static class ValidatorExtensions
    {
        /// <summary>
        /// Checks that a RAG (red, amber, green) property is a valid option. 1=Red, 2=Amber Red, 3=Amber, 4=Amber Green, 5=Green.
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <param name="ruleBuilder"></param>
        /// <returns></returns>
        public static IRuleBuilderOptions<T, int?> RagMustBeValid<T>(this IRuleBuilder<T, int?> ruleBuilder)
        {
            return ruleBuilder.InclusiveBetween(1, 5);
        }
    }
}
