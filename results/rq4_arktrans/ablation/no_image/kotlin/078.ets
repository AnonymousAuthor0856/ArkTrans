@Entry
@Component
struct Index {
  build() {
    Stack() {
      // MaterialTheme is not a standard ArkTS component. 
      // In HarmonyOS, theming is typically handled via CSS variables or system APIs, 
      // but for the purpose of this skeleton conversion where we must implement every child 
      // and cannot use external libraries not present in standard ArkTS, 
      // we will represent the content area. 
      // Since 'MaterialTheme' is not a built-in ArkTS component, we assume it wraps content.
      // We will render a placeholder Column to satisfy "Implement every child" if content was provided,
      // but here content is empty/abstract. We'll leave it as an empty container or comment.
      // However, strict compilation requires valid components. 
      // Given the constraint "NO object literals without an interface", we cannot pass arbitrary props.
      // We will assume the user intends to wrap their UI in a theme context which isn't directly 
      // translatable to a single ArkTS component without custom implementation.
      // To ensure compilability, we will omit the non-existent MaterialTheme wrapper 
      // and just provide the stack, OR if we must keep the structure, we need a dummy component.
      // But the prompt says "Convert... to compilable ArkTS code".
      // Standard ArkTS does not have MaterialTheme. 
      // I will output the Stack with an empty body or a basic container if implied.
      // Looking at the skeleton: MaterialTheme() { }
      // I will replace MaterialTheme with a simple Column or Row if it's meant to be a layout, 
      // but since it's a theme provider, it usually doesn't render anything itself.
      // To be safe and compilable, I will remove the non-standard component and keep the Stack.
      
      // Note: If MaterialTheme is intended to be a custom component defined elsewhere, 
      // it would fail here. Assuming standard library only.
      
    }.width('100%').height('100%')
  }
}