import { IWithErrorHandlingProps } from '../components/withErrorHandling';
import { IWebPartComponentProps } from './WebPartComponentProps';

export interface IBaseComponentProps extends IWebPartComponentProps, IWithErrorHandlingProps { }