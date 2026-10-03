@Entry
@Component
struct Index {
  @State progress: number = 0.5

  build() {
    Stack() {
      // === WindowGroup ===
      // children: 1
      Column() {
        // === ZStack ===
        // props: {"_positional_raw":["AppTokens.Colors.background",".all","true"]}
        // modifiers: ["statusBarHidden(true)","edgesIgnoringSafeArea(.all)","background(AppTokens.Colors.background)"]
        // children: 2
        Stack() {
          // === LinearGradient ===
          // props: {"gradient":"Gradient(colors: [ AppTokens.Colors.secondary.opacity(0.2), AppTokens.Colors.background, AppToken...","startPoint":".top","endPoint":".bottom"}
          // modifiers: ["ignoresSafeArea()"]
          // children: 1
          Column() {
            // === Gradient ===
            // props: {"colors":"[ AppTokens.Colors.secondary.opacity(0.2), AppTokens.Colors.background, AppTokens.Colors.primary...."}
            Text('')
          }.width('100%').height('100%').backgroundColor('#FDF6E3')

          // === VStack ===
          // props: {"spacing":"0"}
          // children: 2
          Column() {
            // === ZStack ===
            // props: {"maxWidth":".infinity"}
            // modifiers: ["frame(maxWidth: .infinity)"]
            // children: 1
            Stack() {
              // === Text ===
              // props: {"text":"Transfer Wizard","_text_raw":"\"Transfer Wizard\"","_positional_raw":["AppTokens.TypographyTokens.display","AppTokens.Colors.onSurface"]}
              // modifiers: ["foregroundColor(AppTokens.Colors.onSurface)","font(AppTokens.TypographyTokens.display)"]
              Text('Transfer Wizard').fontColor('#1E1E1E').fontSize(28).fontWeight(FontWeight.Bold)
            }.width('100%')

            // === ZStack ===
            // props: {"alignment":".center"}
            // children: 2
            Stack() {
              // === Canvas ===
              // props: {"_positional_raw":["AppTokens.Spacing.xl"],"maxWidth":".infinity","maxHeight":".infinity"}
              // modifiers: ["frame(maxWidth: .infinity, maxHeight: .infinity)","padding(AppTokens.Spacing.xl)"]
              // children: 2
              Column().width('100%').height('100%').padding(16)

              // === VStack ===
              // props: {"spacing":"AppTokens.Spacing.lg","maxWidth":".infinity","maxHeight":".infinity","alignment":".bottom","_positional_raw":[".bottom","AppTokens.Spacing.xxl"]}
              // modifiers: ["padding(.bottom, AppTokens.Spacing.xxl)","frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)"]
              // children: 3
              Column() {
                // === Text ===
                // props: {"text":"Transfer Progress","_text_raw":"\"Transfer Progress\"","_positional_raw":["AppTokens.TypographyTokens.title","AppTokens.Colors.onSurface"]}
                // modifiers: ["foregroundColor(AppTokens.Colors.onSurface)","font(AppTokens.TypographyTokens.title)"]
                Text('Transfer Progress').fontColor('#1E1E1E').fontSize(18).fontWeight(FontWeight.Medium)

                // === ProgressView ===
                // props: {"value":"progress","CustomLinearProgressViewStyle( progressColor":"AppTokens.Colors.primary, trackColor: AppTokens.Colors.surfaceVariant, height: 8 // 对应 Kotlin 的 8...","width":"geometry.size.widt..."}
                // modifiers: ["frame(width: geometry.size.width * 0.8)","progressViewStyle(CustomLinearProgressViewStyle( progressColor: #FFA500, trackColor: #FFEED6, height: 8 // 对应 Kotlin 的 8.dp ))"]
                Progress({ value: this.progress, total: 1.0, type: ProgressType.Linear }).width('80%').height(8).color('#FFA500')

                // === HStack ===
                // props: {"spacing":"AppTokens.Spacing.md"}
                // children: 2
                Row() {
                  // === Button ===
                  // props: {"action":"{ progress = min(progress + 0.1, 1.0) // 对应 Kotlin 的 coerceAtMost }"}
                  // modifiers: ["buttonStyle(PlainButtonStyle())"]
                  // children: 2
                  Button() {
                    // === Text ===
                    // props: {"text":"+","_text_raw":"\"+\"",".system(size":"24, weight: .bold)","width":"64","height":"64","_positional_raw":["AppTokens.Colors.primary","AppTokens.Colors.onPrimary"]}
                    // modifiers: ["clipShape(Circle())","foregroundColor(AppTokens.Colors.onPrimary)","background(AppTokens.Colors.primary)","frame(width: 64, height: 64)","font(.system(size: 24, weight: .bold))"]
                    // children: 1
                    Text('+').clipShape(Circle()).fontColor('#FFFFFF').backgroundColor('#FFA500').width(64).height(64).fontSize(24).fontWeight(FontWeight.Bold)
                    // === PlainButtonStyle ===
                    // PlainButtonStyle()
                  }.onClick(() => {
                    this.progress = Math.min(this.progress + 0.1, 1.0)
                  })

                  // === Button ===
                  // props: {"action":"{ progress = max(progress - 0.1, 0.0) // 对应 Kotlin 的 coerceAtLeast }"}
                  // modifiers: ["buttonStyle(PlainButtonStyle())"]
                  // children: 2
                  Button() {
                    // === Text ===
                    // props: {"text":"-","_text_raw":"\"-\"",".system(size":"24, weight: .bold)","width":"64","height":"64","_positional_raw":["AppTokens.Colors.secondary","AppTokens.Colors.onSecondary"]}
                    // modifiers: ["clipShape(Circle())","foregroundColor(AppTokens.Colors.onSecondary)","background(AppTokens.Colors.secondary)","frame(width: 64, height: 64)","font(.system(size: 24, weight: .bold))"]
                    // children: 1
                    Text('-').clipShape(Circle()).fontColor('#1E1E1E').backgroundColor('#FFC300').width(64).height(64).fontSize(24).fontWeight(FontWeight.Bold)
                    // === PlainButtonStyle ===
                    // PlainButtonStyle()
                  }.onClick(() => {
                    this.progress = Math.max(this.progress - 0.1, 0.0)
                  })
                }
              }.alignItems(HorizontalAlign.Center).justifyContent(FlexAlign.End).width('100%').height('100%').padding({ bottom: 32 })
            }.width('100%').height('100%')
          }.width('100%').height('100%')
        }.width('100%').height('100%')
      }.width('100%').height('100%')
    }.width('100%').height('100%')
  }
}