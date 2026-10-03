import { BusinessError } from '@kit.BasicServicesKit';

// --- Design Tokens ---
const AppTokens = {
  Colors: {
    primary: '#FF7042', // rgb(1.0, 0.44, 0.26) -> #FF7042
    secondary: '#FFB84D', // rgb(1.0, 0.72, 0.3) -> #FFB84D
    tertiary: '#FFD180', // rgb(1.0, 0.82, 0.5) -> #FFD180
    background: '#FFF2E0', // rgb(1.0, 0.95, 0.88) -> #FFF2E0
    surface: '#FFFFFF',
    surfaceVariant: '#FFE0B2', // rgb(1.0, 0.88, 0.7) -> #FFE0B2
    outline: '#D6CC C8', // rgb(0.84, 0.8, 0.78) -> #D6CCC8
    success: '#66BA6C', // rgb(0.4, 0.73, 0.42) -> #66BA6C
    warning: '#FFCA29', // rgb(1.0, 0.79, 0.16) -> #FFCA29
    error: '#D42E2E', // rgb(0.83, 0.18, 0.18) -> #D42E2E
    onPrimary: '#FFFFFF',
    onSecondary: '#3D2624', // rgb(0.24, 0.15, 0.14) -> #3D2624
    onBackground: '#3D2624',
    onSurface: '#3D2624'
  },
  Typography: {
    display: { size: 28, weight: FontWeight.Bold },
    title: { size: 18, weight: FontWeight.Medium },
    body: { size: 14, weight: FontWeight.Normal },
    label: { size: 12, weight: FontWeight.Medium }
  },
  Shapes: {
    small: 6,
    medium: 10,
    large: 16
  },
  Spacing: {
    sm: 6,
    md: 10,
    lg: 16,
    xl: 24
  }
};

// --- Custom Slider Component ---
@Component
struct CustomSlider {
  @Link value: number;
  activeColor: string;
  inactiveColor: string;
  thumbColor: string;
  
  private trackHeight: number = 10;
  private thumbDiameter: number = 20;
  private isDragging: boolean = false;

  build() {
    Row() {
      // Background Track
      Rectangle()
        .fill(this.inactiveColor)
        .height(this.trackHeight)
        .borderRadius(this.trackHeight / 2)
      
      // Active Track
      Rectangle()
        .fill(this.activeColor)
        .height(this.trackHeight)
        .borderRadius(this.trackHeight / 2)
        .width(`${this.value * 100}%`)
        .align(Alignment.Start)
        
      // Thumb
      Circle()
        .fill(this.thumbColor)
        .width(this.thumbDiameter)
        .height(this.thumbDiameter)
        .position({ x: `${this.value * 100}%`, y: '50%' })
        .shadow({ radius: 4, color: '#00000033', offsetY: 2 })
    }
    .width('100%')
    .height(this.thumbDiameter)
    .gesture(
      PanGesture()
        .onAction((event: GestureEvent) => {
          if (event.state === GestureStatus.Update || event.state === GestureStatus.Begin) {
            this.isDragging = true;
            const width = this.getGlobalPosition().width; 
            // Note: In ArkTS, getting exact container width inside gesture can be tricky without GeometryReader equivalent logic.
            // We will use a simpler approach: bind to a parent geometry or assume full width relative to parent.
            // For robustness in this specific component structure, we rely on the parent passing width or using a GeometryContainer.
            // However, standard Slider implementation usually handles this internally. 
            // Let's implement a simplified version that works with the provided layout.
          }
        })
    )
  }
}

// Improved Custom Slider using GeometryContainer for accurate drag calculation
@Component
struct RobustCustomSlider {
  @Link value: number;
  activeColor: string;
  inactiveColor: string;
  thumbColor: string;
  
  private trackHeight: number = 10;
  private thumbDiameter: number = 20;

  build() {
    GeometryContainer({ alignContent: Alignment.Start }) {
      Column() {
        Row() {
          // Background Track
          Rectangle()
            .fill(this.inactiveColor)
            .height(this.trackHeight)
            .borderRadius(this.trackHeight / 2)
          
          // Active Track
          Rectangle()
            .fill(this.activeColor)
            .height(this.trackHeight)
            .borderRadius(this.trackHeight / 2)
            .width(`${this.value * 100}%`)
            
          // Thumb
          Circle()
            .fill(this.thumbColor)
            .width(this.thumbDiameter)
            .height(this.thumbDiameter)
            .position({ x: `${this.value * 100}%`, y: '50%' })
            .shadow({ radius: 4, color: '#00000033', offsetY: 2 })
        }
        .width('100%')
        .height(this.thumbDiameter)
        .hitTestBehavior(HitTestMode.Transparent) // Allow gestures to pass through to container if needed, but here we want interaction
        
      }.width('100%')
    }
    .width('100%')
    .height(this.thumbDiameter)
    .gesture(
      PanGesture()
        .onUpdate((event: GestureEvent) => {
          // Calculate new value based on offset
          // This requires knowing the total width. 
          // A better approach for ArkTS custom sliders is often using the built-in Slider component styled heavily, 
          // but since we need a custom look, let's use a simpler binding logic.
        })
    )
  }
}

// Final Custom Slider Implementation using standard Slider for reliability and styling via attributes
@Component
struct StyledSlider {
  @Link value: number;
  activeColor: string;
  inactiveColor: string;
  thumbColor: string;

  build() {
    Slider({ value: this.value, min: 0, max: 1, step: 0.01 })
      .trackThickness(10)
      .selectedColor(this.activeColor)
      .backgroundColor(this.inactiveColor)
      .showValue(false)
      .blockColor(this.thumbColor)
      .width('100%')
  }
}

// --- Main Screen ---
@Entry
@Component
struct RootScreen {
  @State progress: number = 0.42;

  build() {
    Stack() {
      // Background
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor(AppTokens.Colors.background)

      Column() {
        // Title
        Text('Order Tracking')
          .font-size(AppTokens.Typography.display.size)
          .fontWeight(AppTokens.Typography.display.weight)
          .fontColor(AppTokens.Colors.onBackground)
          .textAlign(TextAlign.Start)
          .width('100%')

        // Order Info Card
        Column({ space: AppTokens.Spacing.md }) {
          Text('Order #25491')
            .font-size(AppTokens.Typography.title.size)
            .fontWeight(AppTokens.Typography.title.weight)
            .fontColor(AppTokens.Colors.onSurface)
            .textAlign(TextAlign.Start)
            .width('100%')

          Text('Estimated Delivery: 2 days')
            .font-size(AppTokens.Typography.body.size)
            .fontWeight(AppTokens.Typography.body.weight)
            .fontColor(AppTokens.Colors.secondary)
            .textAlign(TextAlign.Start)
            .width('100%')

          // Progress Bar Visual
          Column() {
            Row() {
              // Background Track
              Rectangle()
                .fill(AppTokens.Colors.surfaceVariant)
                .height(10)
                .borderRadius(5)
              
              // Active Track
              Rectangle()
                .fill(AppTokens.Colors.primary)
                .height(10)
                .borderRadius(5)
                .width(`${this.progress * 100}%`)
            }
            .width('100%')
            .height(10)
          }

          // Progress Labels
          Row() {
            Text('Processing')
              .font-size(AppTokens.Typography.label.size)
              .fontWeight(AppTokens.Typography.label.weight)
              .fontColor(AppTokens.Colors.secondary)
            
            Blank()
            
            Text(`${Math.round(this.progress * 100)}%`)
              .font-size(AppTokens.Typography.label.size)
              .fontWeight(AppTokens.Typography.label.weight)
              .fontColor(AppTokens.Colors.primary)
          }
          .width('100%')
        }
        .padding(AppTokens.Spacing.lg)
        .backgroundColor(AppTokens.Colors.surface)
        .borderRadius(AppTokens.Shapes.large)
        .shadow({ radius: 8, color: '#00000026', offsetX: 0, offsetY: 4 })

        // Adjust Progress Section
        Column({ space: AppTokens.Spacing.md }) {
          Text('Adjust Progress')
            .font-size(AppTokens.Typography.title.size)
            .fontWeight(AppTokens.Typography.title.weight)
            .fontColor(AppTokens.Colors.onSurface)
            .textAlign(TextAlign.Center)
            .width('100%')

          StyledSlider(
            value: $progress,
            activeColor: AppTokens.Colors.primary,
            inactiveColor: AppTokens.Colors.surfaceVariant,
            thumbColor: AppTokens.Colors.primary
          )

          Button('Mark as Delivered')
            .font-size(AppTokens.Typography.label.size)
            .fontWeight(AppTokens.Typography.label.weight)
            .fontColor(AppTokens.Colors.onPrimary)
            .backgroundColor(AppTokens.Colors.primary)
            .borderRadius(AppTokens.Shapes.medium)
            .width('100%')
            .height(40) // Approximate padding vertical md + text height
            .onClick(() => {
              this.progress = 1.0;
            })
        }
        .padding(AppTokens.Spacing.lg)
        .backgroundColor(AppTokens.Colors.surface)
        .borderRadius(AppTokens.Shapes.large)
      }
      .width('100%')
      .padding(AppTokens.Spacing.lg)
    }
    .width('100%')
    .height('100%')
  }
}