import { common, UIAbility } from '@kit.AbilityKit'

interface Point {
  x: number;
  y: number;
}

@Component
struct CustomComponent {
  @Link position: Point
  private size: Size = { width: 280, height: 280 }
  private color: Color = '#FF7A00' as Color

  build() {
    Stack() {
      // Visual Guide Circle
      Circle({ width: 200, height: 200 })
        .fill('#FFC300' as Color)
        .opacity(0.2)

      // Interactive Knob
      Circle({ width: 48, height: 48 })
        .fill(this.color)
        .position({
          x: this.size.width / 2 + this.position.x - 24,
          y: this.size.height / 2 + this.position.y - 24
        })
        .gesture(
          PanGesture()
            .onActionUpdate((event: GestureEvent) => {
              this.position.x += event.offsetX
              this.position.y += event.offsetY
              
              // Clamp within bounds roughly
              const maxDist: number = 100
              const dist: number = Math.sqrt(this.position.x**2 + this.position.y**2)
              if (dist > maxDist) {
                const scale: number = maxDist / dist
                this.position.x *= scale
                this.position.y *= scale
              }
            })
        )
    }
    .width(this.size.width)
    .height(this.size.height)
  }
}

@Entry
@Component
struct RetroRemoteControl {
  @State knobPosition: Point = { x: 0, y: 0 }
  @State powerOn: boolean = false
  private dragOffset: Point = { x: 0, y: 0 }

  // AppTokens Colors
  private readonly primary: Color = '#FF7A00' as Color
  private readonly secondary: Color = '#FFC300' as Color
  private readonly tertiary: Color = '#FFF3C0' as Color
  private readonly background: Color = '#FFF8E7' as Color
  private readonly surface: Color = '#FFFFFF' as Color
  private readonly surfaceVariant: Color = '#FFEBC8' as Color
  private readonly outline: Color = '#BCA789' as Color
  private readonly success: Color = '#28A745' as Color
  private readonly warning: Color = '#FFC107' as Color
  private readonly error: Color = '#DC3545' as Color
  private readonly onPrimary: Color = '#FFFFFF' as Color
  private readonly onSecondary: Color = '#1E1E1E' as Color
  private readonly onTertiary: Color = '#1E1E1E' as Color
  private readonly onBackground: Color = '#1E1E1E' as Color
  private readonly onSurface: Color = '#1E1E1E' as Color

  build() {
    Column() {
      // Top Bar
      Row() {
        Text('Retro Remote Control')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.onSurface)
      }
      .width('100%')
      .height(60)
      .justifyContent(FlexAlign.Center)
      .backgroundColor(this.background)

      // Main Content
      Column() {
        // Knob Surface
        Column() {
          Stack({ alignContent: Alignment.Center }) {
            // Background Circle (Visual Guide)
            Circle({ width: '100%', height: '100%' })
              .fill(Color.Transparent)
              .borderWidth(0)
            
            // Canvas for Knob
            CustomComponent({
              position: $knobPosition,
              size: { width: 280, height: 280 },
              color: this.primary
            })
          }
          .width(280)
          .height(280)
          .borderRadius(24)
          .backgroundColor(this.surfaceVariant)
          .shadow({ radius: 8, color: 'rgba(0,0,0,0.12)', offsetY: 4 })
        }

        // Power Status Text
        Text(this.powerOn ? "Power: ON" : "Power: OFF")
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.powerOn ? this.success : this.error)
          .margin({ top: 24 })

        // Buttons Row
        Row() {
          // Power Button
          Button(this.powerOn ? "Off" : "On")
            .type(ButtonType.Capsule)
            .backgroundColor(this.primary)
            .fontColor(this.onPrimary)
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .width(80)
            .height(80)
            .onClick(() => {
              this.powerOn = !this.powerOn
            })

          Blank().width(16)

          // Reset Button
          Button("Reset")
            .type(ButtonType.Capsule)
            .backgroundColor(this.secondary)
            .fontColor(this.onSecondary)
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .width(80)
            .height(80)
            .onClick(() => {
              this.knobPosition = { x: 0, y: 0 }
            })
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceEvenly)
        .margin({ top: 24 })

        // Progress Indicator
        Row() {
          Rect()
            .width(`${Math.max(0, Math.min(100, ((this.knobPosition.x + this.knobPosition.y) % 400) / 400 * 100))}%`)
            .height(6)
            .fill(this.primary)
            .borderRadius(3)
        }
        .width('100%')
        .height(6)
        .backgroundColor(this.surfaceVariant)
        .borderRadius(3)
        .margin({ top: 24 })
      }
      .width('100%')
      .padding(16)
      .alignItems(HorizontalAlign.Center)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.background)
  }
}