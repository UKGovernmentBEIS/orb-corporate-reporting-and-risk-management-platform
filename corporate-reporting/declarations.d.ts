// Added to prevent errors in DevOps CI
// We need to tell TypeScript that when we write "import styles from './styles.scss' we mean to load a module (to look for a './styles.scss.d.ts').
declare module "*.scss" {
    const content: { [className: string]: string };
    export = content;
}