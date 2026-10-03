import { window } from '@kit.ArkUI'

// --- Design Tokens & Constants ---

interface AppColors {
  primary: string;
  secondary: string;
  tertiary: string;
  background: string;
  surface: string;
  surfaceVariant: string;
  outline: string;
  success: string;
  warning: string;
  error: string;
  onPrimary: string;
  onSecondary: string;
  onTertiary: string;
  onBackground: string;
  onSurface: string;
}

interface AppSpacing {
  xs: number;
  sm: number;
  md: number;
  lg: number;
  xl: number;
  xxl: number;
}

interface AppRadius {
  small: number;
  medium: number;
  large: number;
}

const AppTokens = {
  Colors: {
    primary: '#1E3A8A',
    secondary: '#2563EB',
    tertiary: '#60A5FA',
    background: '#F5F8FF',
    surface: '#FFFFFF',
    surfaceVariant: '#E8EEFA',
    outline: '#CBD5E1',
    success: '#16A34A',
    warning: '#F59E0B',
    error: '#EF4444',
    onPrimary: '#FFFFFF',
    onSecondary: '#FFFFFF',
    onTertiary: '#0B1220',
    onBackground: '#0B1220',
    onSurface: '#0B1220'
  } as AppColors,
  Spacing: {
    xs: 6,
    sm: 10,
    md: 14,
    lg: 18,
    xl: 26,
    xxl: 36
  } as AppSpacing,
  Radius: {
    small: 8,
    medium: 12,
    large: 18
  } as AppRadius
}

@Entry
@Component
struct FlightCheckinApp {
  @State name: string = ''
  @State code: string = ''
  @State selectedSeatIndex: number = 0
  @State showDialog: boolean = false
  
  private seatTabs: string[] = ['Economy', 'Premium', 'Business']
  
  // Helper to get seat based on selection
  getSelectedSeat(): string {
    if (this.selectedSeatIndex === 0) return "23C"
    if (this.selectedSeatIndex === 1) return "11A"
    return "2F"
  }

  build() {
    Stack() {
      Column() {
        // Top Bar
        Row() {
          Circle({ radius: 11 })
            .width(22)
            .height(22)
            .backgroundColor(AppTokens.Colors.primary)
          
          Text('Flight Check-in')
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
            .fontColor(AppTokens.Colors.onSurface)
            .textAlign(TextAlign.Center)
            .layoutWeight(1)
          
          Circle({ radius: 11 })
            .width(22)
            .height(22)
            .backgroundColor(AppTokens.Colors.secondary)
        }
        .width('100%')
        .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: 40, bottom: 10 })
        
        // Main Content Scrollable
        Scroll() {
          Column() {
            // Passenger Card
            CardComponent({ 
              name: $name, 
              code: $code, 
              selectedSeatIndex: $selectedSeatIndex, 
              seatTabs: this.seatTabs 
            })
            
            // Flight Info Card
            FlightInfoCard({ 
              selectedSeatIndex: $selectedSeatIndex, 
              onConfirm: () => { this.showDialog = true } 
            })
            
            // Bottom padding for scroll
            Blank().height(40)
          }
          .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
          .width('100%')
        }
        .layoutWeight(1)
        .scrollBar(BarState.Off)
      }
      .width('100%')
      .height('100%')
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [
          [AppTokens.Colors.tertiary, 0.25],
          [AppTokens.Colors.background, 0.5],
          [AppTokens.Colors.secondary, 0.2]
        ]
      })

      // Dialog Overlay
      if (this.showDialog) {
        CheckinSuccessDialog({ onClose: () => { this.showDialog = false } })
      }
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}

@Component
struct CardComponent {
  @Link name: string
  @Link code: string
  @Link selectedSeatIndex: number
  seatTabs: string[] = []

  build() {
    Column() {
      Text("Passenger")
        .fontSize(20)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppTokens.Colors.onSurface)
      
      TextInput({ placeholder: 'Full name', text: this.name })
        .type(InputType.Normal)
        .onChange((value: string) => { this.name = value })
        .margin({ top: AppTokens.Spacing.sm })
      
      Text("Booking Code")
        .fontSize(20)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppTokens.Colors.onSurface)
        .margin({ top: AppTokens.Spacing.md })
      
      TextInput({ placeholder: 'e.g. XY7ZK2', text: this.code })
        .type(InputType.Normal)
        .onChange((value: string) => { this.code = value })
        .margin({ top: AppTokens.Spacing.sm })
      
      Text("Seat Class")
        .fontSize(20)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppTokens.Colors.onSurface)
        .margin({ top: AppTokens.Spacing.md })
      
      // Segmented Button Row Implementation
      Flex({ wrap: FlexWrap.NoWrap, justifyContent: FlexAlign.SpaceBetween }) {
        ForEach(this.seatTabs, (label: string, index: number) => {
          Button(label)
            .width(`${100 / this.seatTabs.length}%`)
            .height(40)
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .borderWidth(1)
            .borderColor(AppTokens.Colors.outline)
            .borderRadius(AppTokens.Radius.medium)
            .margin({ right: index < this.seatTabs.length - 1 ? 4 : 0 })
            .onClick(() => { this.selectedSeatIndex = index })
            .backgroundColor(this.selectedSeatIndex === index ? AppTokens.Colors.primary : AppTokens.Colors.surfaceVariant)
            .fontColor(this.selectedSeatIndex === index ? AppTokens.Colors.onPrimary : AppTokens.Colors.onSurface)
            .borderColor(this.selectedSeatIndex === index ? AppTokens.Colors.primary : AppTokens.Colors.outline)
        })
      }
      .width('100%')
      .margin({ top: AppTokens.Spacing.sm })
    }
    .width('100%')
    .padding(AppTokens.Spacing.lg)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Radius.large)
    .shadow({ radius: 8, color: 'rgba(0,0,0,0.1)', offsetY: 4 })
    .margin({ bottom: AppTokens.Spacing.lg })
  }
}

@Component
struct FlightInfoCard {
  @Link selectedSeatIndex: number
  onConfirm: () => void = () => {}

  build() {
    Column() {
      Row() {
        Column() {
          Text("Flight")
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppTokens.Colors.onSurface)
          Text("BL 213 • HND → CTS")
            .fontSize(14)
            .fontColor(AppTokens.Colors.onSurface)
            .margin({ top: 6 })
        }
        .layoutWeight(1)
        
        Circle({ radius: 18 })
          .width(36)
          .height(36)
          .backgroundColor(AppTokens.Colors.secondary)
      }
      .width('100%')
      
      Divider().color(AppTokens.Colors.outline).margin({ top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.md })
      
      Row() {
        Column() {
          Text("Boarding")
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppTokens.Colors.onSurface)
          Text("12:35")
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppTokens.Colors.primary)
            .margin({ top: 4 })
        }
        .layoutWeight(1)
        
        Column() {
          Text("Gate")
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppTokens.Colors.onSurface)
          Text("A12")
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppTokens.Colors.primary)
            .margin({ top: 4 })
        }
        .layoutWeight(1)
        
        Column() {
          Text("Seat")
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppTokens.Colors.onSurface)
          Text(this.getSelectedSeat())
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppTokens.Colors.primary)
            .margin({ top: 4 })
        }
        .layoutWeight(1)
      }
      .width('100%')
      
      Button("Confirm Check-in")
        .width('100%')
        .height(52)
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .backgroundColor(AppTokens.Colors.primary)
        .fontColor(AppTokens.Colors.onPrimary)
        .borderRadius(AppTokens.Radius.large)
        .margin({ top: AppTokens.Spacing.lg })
        .onClick(() => { this.onConfirm() })
    }
    .width('100%')
    .padding(AppTokens.Spacing.lg)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Radius.large)
    .shadow({ radius: 8, color: 'rgba(0,0,0,0.1)', offsetY: 4 })
  }
  
  getSelectedSeat(): string {
    if (this.selectedSeatIndex === 0) return "23C"
    if (this.selectedSeatIndex === 1) return "11A"
    return "2F"
  }
}

@Component
struct CheckinSuccessDialog {
  onClose: () => void = () => {}

  build() {
    Stack() {
      // Backdrop
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor('rgba(0,0,0,0.5)')
        .onClick(() => { this.onClose() })
      
      // Dialog Box
      Column() {
        Text("Check-in Successful")
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onSurface)
          .margin({ bottom: AppTokens.Spacing.sm })
        
        Text("Boarding pass is ready. Have a nice flight.")
          .fontSize(14)
          .fontColor(AppTokens.Colors.onSurface)
          .margin({ bottom: AppTokens.Spacing.lg })
        
        Button("Done")
          .width('100%')
          .height(40)
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .backgroundColor(AppTokens.Colors.secondary)
          .fontColor(AppTokens.Colors.onSecondary)
          .borderRadius(AppTokens.Radius.medium)
          .onClick(() => { this.onClose() })
      }
      .width('80%')
      .padding(AppTokens.Spacing.lg)
      .backgroundColor(AppTokens.Colors.surface)
      .borderRadius(AppTokens.Radius.medium)
    }
    .width('100%')
    .height('100%')
    .position({ x: 0, y: 0 })
  }
}