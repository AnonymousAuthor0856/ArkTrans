@Entry
@Component
struct Index {
  build() {
    Stack() {
      // === WindowGroup ===
      // children: 1
      Column() {
        // === ZStack ===
        // props: {"_positional_raw":["true"]}
        // modifiers: ["statusBarHidden(true)"]
        // children: 4
        Stack() {
          // === Canvas ===
          // props: {"DragGesture(minimumDistance":"0) // minimumDistance: 0 确保每次位置变化都触发 .onChanged { value in nodes.append(value.location) }","_positional_raw":[".all"]}
          // modifiers: ["ignoresSafeArea(.all)","gesture( DragGesture(minimumDistance: 0) // minimumDistance: 0 确保每次位置变化都触发 .o..."]
          // children: 3
          Canvas({})

          // === VStack ===
          // props: {"_positional_raw":[".container"],"edges":".top"}
          // modifiers: ["ignoresSafeArea(.container, edges: .top)"]
          // children: 2
          Column() {
            // === Text ===
            // props: {"text":"Neon Mind Map","_text_raw":"\"Neon Mind Map\"","_positional_raw":"['AppTokens.TypographyTokens.display', 'AppTokens.Colors.primary', '.vertical', 'AppTokens.Spacin...","maxWidth":".infinity"}
            // modifiers: ["background(AppTokens.Colors.background)","frame(maxWidth: .infinity)","padding(.vertical, AppTokens.Spacing.lg)","foregroundColor(AppTokens.Colors.primary)","font(AppTokens.TypographyTokens.displ...
            Text('Neon Mind Map')
              .backgroundColor('#FF0D0D0D')
              .width('100%')
              .padding({ top: 12, bottom: 12 })
              .fontColor('#FF00FFFF')
              .fontSize(28)

            // === Spacer ===
            Blank()
          }

          // === VStack ===
          // props: {"_positional_raw":[".container"],"edges":".bottom"}
          // modifiers: ["ignoresSafeArea(.container, edges: .bottom)"]
          // children: 2
          Column() {
            // === Spacer ===
            Blank()

            // === HStack ===
            // props: {"spacing":"AppTokens.Spacing.md","_positional_raw":["AppTokens.Spacing.md","AppTokens.Colors.surfaceVariant"],"maxWidth":".infinity","color":".black.opacity(AppTokens.ElevationMapping.level1.opaci...
            // modifiers: ["shadow(color: .black.opacity(AppTokens.ElevationMapping.level1.opacity), radi...","background(AppTokens.Colors.surfaceVariant)","frame(maxWidth: .infinity)","padding(AppTokens.Spacing.md)"]
            // children: 3
            Row() {
              // === Button ===
              // props: {"action":"{ currentColor = AppTokens.Colors.primary }","_positional_raw":["AppTokens.Colors.primary","15"]}
              // modifiers: ["buttonStyle(PlainButtonStyle())","cornerRadius(15)","background(AppTokens.Colors.primary)"]
              // children: 2
              Button() {
                // === Text ===
                // props: {"text":"Cyan","_text_raw":"\"Cyan\"","_positional_raw":"['AppTokens.TypographyTokens.body', 'AppTokens.Colors.onPrimary', '.horizontal', 'AppTokens.Spaci..."}
                // modifiers: ["padding(.vertical, AppTokens.Spacing.sm)","padding(.horizontal, AppTokens.Spacing.lg)","foregroundColor(AppTokens.Colors.onPrimary)","font(AppTokens.TypographyTokens.body)"]
                Text('Cyan')
                  .padding({ top: 4, bottom: 4 })
                  .padding({ left: 12, right: 12 })
                  .fontColor('#FF000000')
                  .fontSize(14)
              }
              .borderRadius(15)
              .backgroundColor('#FF00FFFF')

              // === Button ===
              // props: {"action":"{ currentColor = AppTokens.Colors.secondary }","_positional_raw":["AppTokens.Colors.secondary","15"]}
              // modifiers: ["buttonStyle(PlainButtonStyle())","cornerRadius(15)","background(AppTokens.Colors.secondary)"]
              // children: 2
              Button() {
                // === Text ===
                // props: {"text":"Green","_text_raw":"\"Green\"","_positional_raw":"['AppTokens.TypographyTokens.body', 'AppTokens.Colors.onSecondary', '.horizontal', 'AppTokens.Spa..."}
                // modifiers: ["padding(.vertical, AppTokens.Spacing.sm)","padding(.horizontal, AppTokens.Spacing.lg)","foregroundColor(AppTokens.Colors.onSecondary)","font(AppTokens.TypographyTokens.body)"]
                Text('Green')
                  .padding({ top: 4, bottom: 4 })
                  .padding({ left: 12, right: 12 })
                  .fontColor('#FF000000')
                  .fontSize(14)
              }
              .borderRadius(15)
              .backgroundColor('#FF00FF88')

              // === Button ===
              // props: {"action":"{ currentColor = AppTokens.Colors.tertiary }","_positional_raw":["AppTokens.Colors.tertiary","15"]}
              // modifiers: ["buttonStyle(PlainButtonStyle())","cornerRadius(15)","background(AppTokens.Colors.tertiary)"]
              // children: 2
              Button() {
                // === Text ===
                // props: {"text":"Purple","_text_raw":"\"Purple\"","_positional_raw":"['AppTokens.TypographyTokens.body', 'AppTokens.Colors.onTertiary', '.horizontal', 'AppTokens.Spac..."}
                // modifiers: ["padding(.vertical, AppTokens.Spacing.sm)","padding(.horizontal, AppTokens.Spacing.lg)","foregroundColor(AppTokens.Colors.onTertiary)","font(AppTokens.TypographyTokens.body)"]
                Text('Purple')
                  .padding({ top: 4, bottom: 4 })
                  .padding({ left: 12, right: 12 })
                  .fontColor('#FF000000')
                  .fontSize(14)
              }
              .borderRadius(15)
              .backgroundColor('#FFBB86FC')
            }
            .width('100%')
            .padding(12)
            .backgroundColor('#333333')
            .shadow({ radius: 6, color: '#33000000' })
          }

          // === VStack ===
          // children: 2
          Column() {
            // === Spacer ===
            Blank()

            // === HStack ===
            // children: 2
            Row() {
              // === Spacer ===
              Blank()

              // === Button ===
              // props: {"action":"{ // 对应 Kotlin 的随机位置生成 let randomX = CGFloat.random(in: 100...600) let randomY = CGFloat.random(i...","_positional_raw":["AppTokens.Spacing.lg"]}
              // modifiers: ["padding(AppTokens.Spacing.lg)"]
              // children: 1
              Button() {
                // === Text ===
                // props: {"text":"+","_text_raw":"\"+\"","_positional_raw":["AppTokens.TypographyTokens.title","AppTokens.Colors.onSecondary","AppTokens.Colors.secondary"],"width":"56","height":"56","color":".black.opacity...
                // modifiers: ["shadow(color: .black.opacity(AppTokens.ElevationMapping.level2.opacity), radi...","clipShape(Circle())","background(AppTokens.Colors.secondary)","frame(width: 56, height: 56)","foregroundColor(Ap...
                // children: 1
                Text('+')
                  .shadow({ radius: 8, color: '#4D000000', offsetX: 0, offsetY: 4 })
                  .borderRadius(28)
                  .backgroundColor('#FF00FF88')
                  .width(56)
                  .height(56)
                  .fontColor('#FF000000')
                  .fontSize(18)
                  .textAlign(TextAlign.Center)
              }
              .padding(12)
            }
          }
        }
      }
    }
    .width('100%')
    .height('100%')
  }
}