@Entry
@Component
struct Index {
  build() {
    Stack() {
      // === ZStack (Main Content) ===
      Stack({ alignContent: Alignment.BottomEnd }) {
        // === VStack (Scrollable Content Area) ===
        Column() {
          // Spacer for top padding
          Blank().height(20)

          // Text: Sign In to Continue
          Text('Sign In to Continue')
            .fontColor('#1E293B')
            .fontSize(20)
            .fontWeight(FontWeight.Medium)
            .textAlign(TextAlign.Center)
            .width('100%')
            .margin({ bottom: 24 })

          // Workout Preview Card
          Stack() {
            // Background Rect with Stroke
            Rect()
              .fill(Color.White)
              .stroke('#CBD5E1', { width: 1 })
              .borderRadius(24)
              .width('100%')
              .height(200)

            // Text inside card
            Text('Workout Preview')
              .fontColor('#1E293B')
              .fontSize(16)
          }
          .width('100%')
          .margin({ bottom: 24 })

          // Authenticate Button
          Button() {
            Text('Authenticate')
              .fontColor('#FFFFFF')
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
          }
          .backgroundColor('#2563EB')
          .borderRadius(24)
          .width('80%')
          .height(52)
          .margin({ bottom: 24 })

          // Spacer to push content up if needed, though layout is mostly top-down
          Blank()

          // Gradient Background Overlay (Simulated via LinearGradient on a full screen rect behind or just the column bg)
          // The skeleton implies a gradient background. We apply it to the main column.
        }
        .width('100%')
        .height('100%')
        .padding({ left: 24, right: 24 })
        .backgroundColor('#F1F5F9') // Fallback base color
        .linearGradient({
          angle: 180,
          colors: [['#E0E7FF', 0], ['#DBEAFE', 1]]
        })

        // === Top Bar (Header) ===
        Column() {
          Text('Workout Plan')
            .fontColor('#0F172A')
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
            .textAlign(TextAlign.Center)
            .width('100%')
        }
        .width('100%')
        .height(60)
        .backgroundColor('#FFFFFF')
        .position({ x: 0, y: 0 })

        // === Bottom Navigation Bar ===
        Column() {
          Row() {
            Text('Home')
              .fontColor('#2563EB')
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .layoutWeight(1)
              .textAlign(TextAlign.Center)

            Text('Plan')
              .fontColor('#1E293B')
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .layoutWeight(1)
              .textAlign(TextAlign.Center)

            Text('Profile')
              .fontColor('#1E293B')
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .layoutWeight(1)
              .textAlign(TextAlign.Center)
          }
          .width('100%')
          .height(60)
          .alignItems(VerticalAlign.Center)
        }
        .width('100%')
        .backgroundColor('#FFFFFF')
        .shadow({ radius: 10, color: '#00000010' })
        .position({ x: 0, y: -60 }) // Align to bottom relative to stack center? No, Stack alignment handles this.
        // Actually, since the parent Stack is BottomEnd aligned, we need to be careful.
        // Let's restructure the Stack children to use absolute positioning or standard stacking logic.
        // The skeleton uses a ZStack-like structure.
        // To make it robust in ArkTS Stack:
        // 1. Main Content (Column) takes full space.
        // 2. Header (Column) positioned at top.
        // 3. Footer (Column) positioned at bottom.
        // 4. FAB positioned at bottom end.
        
        // Correction: The previous code block mixed modifiers. 
        // Let's refine the structure below to match the visual exactly using the Stack provided.
        
      }
      .width('100%')
      .height('100%')
      
      // Re-implementing the specific layers based on the screenshot and skeleton logic
      
      // Layer 1: Main Scrollable Content
      Column() {
        Blank().height(80) // Space for header
        
        Text('Sign In to Continue')
          .fontColor('#1E293B')
          .fontSize(20)
          .fontWeight(FontWeight.Medium)
          .textAlign(TextAlign.Center)
          .width('100%')
          .margin({ bottom: 24 })

        Stack() {
          Rect()
            .fill(Color.White)
            .stroke('#CBD5E1', { width: 1 })
            .borderRadius(24)
            .width('100%')
            .height(200)
          
          Text('Workout Preview')
            .fontColor('#1E293B')
            .fontSize(16)
        }
        .width('100%')
        .margin({ bottom: 24 })

        Button() {
          Text('Authenticate')
            .fontColor('#FFFFFF')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
        }
        .backgroundColor('#2563EB')
        .borderRadius(24)
        .width('80%')
        .height(52)
        
        Blank()
      }
      .width('100%')
      .height('100%')
      .padding({ left: 24, right: 24 })
      .linearGradient({
        angle: 180,
        colors: [['#EFF6FF', 0], ['#DBEAFE', 1]]
      })

      // Layer 2: Header
      Column() {
        Text('Workout Plan')
          .fontColor('#0F172A')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .textAlign(TextAlign.Center)
          .width('100%')
      }
      .width('100%')
      .height(60)
      .backgroundColor('#FFFFFF')
      .position({ x: 0, y: 0 })

      // Layer 3: Bottom Nav
      Column() {
        Row() {
          Text('Home')
            .fontColor('#2563EB')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .layoutWeight(1)
            .textAlign(TextAlign.Center)

          Text('Plan')
            .fontColor('#1E293B')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .layoutWeight(1)
            .textAlign(TextAlign.Center)

          Text('Profile')
            .fontColor('#1E293B')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .layoutWeight(1)
            .textAlign(TextAlign.Center)
        }
        .width('100%')
        .height(60)
        .alignItems(VerticalAlign.Center)
      }
      .width('100%')
      .height(60)
      .backgroundColor('#FFFFFF')
      .shadow({ radius: 10, color: '#00000010' })
      .position({ x: 0, y: -60 }) // Relative to bottom of stack

      // Layer 4: FAB
      Button() {
        Text('+')
          .fontColor('#FFFFFF')
          .fontSize(32)
          .fontWeight(FontWeight.Bold)
      }
      .backgroundColor('#2563EB')
      .borderRadius(30)
      .width(60)
      .height(60)
      .shadow({ radius: 8, color: '#00000020' })
      .position({ x: -24, y: -24 }) // Relative to BottomEnd alignment of the main Stack

    }
    .width('100%')
    .height('100%')
  }
}