import { Window } from '@kit.ArkUI'
import { common, UIAbility } from '@kit.AbilityKit'

@Entry
@Component
struct RetroRemoteControl {
  @State knobPosition: Point = { x: 0, y: 0 }
  @State powerOn: boolean = false
  private dragOffset: Point = { x: 0, y: 0 }

  // AppTokens Colors
  private readonly primary: Color = '#FF7A00'
  private readonly secondary: Color = '#FFC300'
  private readonly tertiary: Color = '#FFF3C0'
  private readonly background: Color = '#FFF8E7'
  private readonly surface: Color = '#FFFFFF'
  private readonly surfaceVariant: Color = '#FFEBC8'
  private readonly outline: Color = '#BCA789'
  private readonly success: Color = '#28A745'
  private readonly warning: Color = '#FFC107'
  private readonly error: Color = '#DC3545'
  private readonly onPrimary: Color = '#FFFFFF'
  private readonly onSecondary: Color = '#1E1E1E'
  private readonly onTertiary: Color = '#1E1E1E'
  private readonly onBackground: Color = '#1E1E1E'
  private readonly onSurface: Color = '#1E1E1E'

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
              position: this.knobPosition,
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
            .fillColor(this.primary)
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

@Component
struct CustomComponent {
  @Link position: Point
  private size: Size = { width: 280, height: 280 }
  private color: Color = '#FF7A00'

  build() {
    Stack() {
      // Visual Guide Circle
      Circle({ width: 200, height: 200 })
        .fill('#FFC300')
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
              const maxDist = 100
              const dist = Math.sqrt(this.position.x**2 + this.position.y**2)
              if (dist > maxDist) {
                const scale = maxDist / dist
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