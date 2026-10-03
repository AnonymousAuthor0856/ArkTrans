import { window } from '@kit.ArkUI';
import { common, UIAbility, Want } from '@kit.AbilityKit';

@Entry
@Component
struct CryptoMarketApp {
  @State selectedChip: string = 'BTC'
  @State progress: number = 0.6
  @State isAutoUpdate: boolean = true
  
  // Colors
  private readonly primaryColor: ResourceColor = '#FFA8A8' as ResourceColor
  private readonly secondaryColor: ResourceColor = '#FFE1A8' as ResourceColor
  private readonly tertiaryColor: ResourceColor = '#A8FFE1' as ResourceColor
  private readonly backgroundColor: ResourceColor = '#FFFCF5' as ResourceColor
  private readonly surfaceColor: ResourceColor = '#FFFFFF' as ResourceColor
  private readonly surfaceVariantColor: ResourceColor = '#F7F7F7' as ResourceColor
  private readonly outlineColor: ResourceColor = '#E2E2E2' as ResourceColor
  private readonly onSurfaceColor: ResourceColor = '#1E1E1E' as ResourceColor
  
  // Spacing
  private readonly spacingSm: number = 8
  private readonly spacingMd: number = 12
  private readonly spacingLg: number = 16
  private readonly spacingXl: number = 24
  
  build() {
    Column() {
      // Top Bar
      Row() {
        Text('Crypto Market')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.onSurfaceColor)
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Center)
      .backgroundColor(this.backgroundColor)
      
      // Main Content
      Column() {
        // Filter Chips
        Row() {
          this.buildChip('BTC')
          this.buildChip('ETH')
          this.buildChip('SOL')
          this.buildChip('ADA')
        }
        .width('100%')
        .justifyContent(FlexAlign.Start)
        .margin({ top: this.spacingLg })
        
        // Chart Card
        Row() {
          Canvas(this.drawChart.bind(this))
            .width('100%')
            .height('100%')
        }
        .width('100%')
        .height(260)
        .borderRadius(20)
        .backgroundColor(this.surfaceColor)
        .shadow({ radius: 8, color: 'rgba(0,0,0,0.18)', offsetY: 4 })
        .margin({ top: this.spacingLg })
        
        // Price Variation Label
        Text('Price Variation')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.primaryColor)
          .margin({ top: this.spacingLg })
          
        // Progress Bar
        Row() {
          Rect()
            .fill(this.primaryColor)
            .width(`${this.progress * 100}%`)
            .height(8)
            .borderRadius(4)
        }
        .width('100%')
        .height(8)
        .backgroundColor(this.surfaceVariantColor)
        .borderRadius(4)
        .margin({ top: this.spacingMd })
        
        // Auto Update Switch
        Row() {
          Text('Auto Update')
            .fontSize(14)
            .fontColor(this.onSurfaceColor)
            
          Blank()
          
          Toggle({ type: ToggleType.Switch })
            .checked(this.isAutoUpdate)
            .onChange((isOn: boolean) => {
              this.isAutoUpdate = isOn
            })
            .selectedColor(this.secondaryColor)
        }
        .width('100%')
        .margin({ top: this.spacingLg })
      }
      .width('100%')
      .layoutWeight(1)
      .padding(this.spacingLg)
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [
          [this.secondaryColor, 0.3],
          [this.backgroundColor, 0.5],
          [this.tertiaryColor, 0.3]
        ]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.backgroundColor)
  }
  
  @Builder
  buildChip(label: string) {
    Button(label)
      .type(ButtonType.Capsule)
      .backgroundColor(this.selectedChip === label ? this.primaryColor : this.surfaceVariantColor)
      .fontColor(this.onSurfaceColor)
      .fontSize(14)
      .fontWeight(FontWeight.Medium)
      .margin({ right: this.spacingMd })
      .onClick(() => {
        this.selectedChip = label
      })
  }
  
  drawChart(context: CanvasRenderingContext2D, width: number, height: number) {
    const padding: number = this.spacingLg
    
    context.beginPath()
    context.strokeStyle = this.primaryColor as string
    context.lineWidth = 5
    context.lineCap = 'round'
    context.lineJoin = 'round'
    
    const step: number = (width - 2 * padding) / 30
    let prevY: number = height / 2
    
    for (let i: number = 0; i <= 30; i++) {
      const x: number = padding + i * step
      const y: number = height / 2 + Math.sin(i * Math.PI / 6 + this.progress * Math.PI) * (height / 3)
      
      if (i === 0) {
        context.moveTo(x, y)
      } else {
        context.lineTo(x, y)
      }
      prevY = y
    }
    
    context.stroke()
  }
}