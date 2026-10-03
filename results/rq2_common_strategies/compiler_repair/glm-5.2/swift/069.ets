// Data Models
interface CargoCard {
  id: string;
  title: string;
  itemId: string;
  fill: string;
}

interface HubFilter {
  id: string;
  label: string;
}

// Design Tokens
class DesignTokens {
  static Colors: Record<string, string> = {
    primary: '#8B6B4C',
    secondary: '#C27D38',
    tertiary: '#F2C57C',
    background: '#100C08',
    surface: '#19110D',
    surfaceVariant: '#2A1C14',
    outline: '#4F3A2C',
    success: '#6ECE89',
    warning: '#E19F41',
    error: '#D96666',
    onPrimary: '#100C08',
    onSecondary: '#100C08',
    onTertiary: '#120E04',
    onBackground: '#F7EAD8',
    onSurface: '#FBEFE0'
  }
  
  static Spacing: Record<string, number> = {
    xxs: 6,
    xs: 10,
    sm: 14,
    md: 18,
    lg: 26,
    xl: 36,
    xxl: 48,
    xxxl: 62
  }
  
  static CornerRadius: Record<string, number> = {
    small: 10,
    medium: 18,
    large: 26
  }
}

@Entry
@Component
struct SupplyHubApp {
  @State activeFilter: string = 'All';
  
  private cards: CargoCard[] = [
    { id: '1', title: 'Copper stack', itemId: 'SH-014', fill: '78%' },
    { id: '2', title: 'Fiber reels', itemId: 'SH-022', fill: '64%' },
    { id: '3', title: 'Agro crates', itemId: 'SH-031', fill: '92%' },
    { id: '4', title: 'Glass kits', itemId: 'SH-045', fill: '51%' },
    { id: '5', title: 'Steel mesh', itemId: 'SH-057', fill: '88%' },
    { id: '6', title: 'Raw silica', itemId: 'SH-063', fill: '43%' }
  ];
  
  private filters: HubFilter[] = [
    { id: '1', label: 'All' },
    { id: '2', label: 'Atlantic' },
    { id: '3', label: 'Pacific' },
    { id: '4', label: 'Inland' }
  ];

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      // Background
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor(DesignTokens.Colors.background)
        
      // Main Container
      Column() {
        // Top App Bar
        this.TopAppBar()
        
        // Scrollable Content
        Scroll() {
          Column({ space: DesignTokens.Spacing.lg }) {
            // Filter Buttons
            this.FilterButtons()
            
            // Cargo Grid Section
            Text('Cargo grid')
              .fontSize(22)
              .fontWeight(FontWeight.Medium)
              .fontColor(DesignTokens.Colors.onSurface)
              .margin({ left: DesignTokens.Spacing.lg, right: DesignTokens.Spacing.lg })
            
            // Grid Layout
            Grid() {
              ForEach(this.cards, (card: CargoCard) => {
                GridItem() {
                  this.CargoCardView(card)
                }
              })
            }
            .columnsTemplate('1fr 1fr')
            .columnsGap(DesignTokens.Spacing.sm)
            .rowsGap(DesignTokens.Spacing.sm)
            .padding({ left: DesignTokens.Spacing.lg, right: DesignTokens.Spacing.lg })
            
            // Manifest Filter Section
            Column({ space: DesignTokens.Spacing.xs }) {
              Text('Manifest filter')
                .fontSize(12)
                .fontWeight(FontWeight.Medium)
                .fontColor(DesignTokens.Colors.onSurface)
                .opacity(0.7)
              
              Text(this.activeFilter)
                .fontSize(16)
                .fontWeight(FontWeight.Medium)
                .fontColor(DesignTokens.Colors.onSurface)
            }
            .width('100%')
            .alignItems(HorizontalAlign.Start)
            .padding({ left: DesignTokens.Spacing.lg, right: DesignTokens.Spacing.lg, top: DesignTokens.Spacing.md, bottom: DesignTokens.Spacing.md })
            .backgroundColor(DesignTokens.Colors.surfaceVariant)
            .opacity(0.85)
            .borderRadius(DesignTokens.CornerRadius.medium)
            .margin({ left: DesignTokens.Spacing.lg, right: DesignTokens.Spacing.lg })
          }
          .padding({ top: DesignTokens.Spacing.md, bottom: DesignTokens.Spacing.md })
          .alignItems(HorizontalAlign.Start)
        }
        .layoutWeight(1)
        .scrollBar(BarState.Off)
        .align(Alignment.TopStart)
      }
    }
    .width('100%')
    .height('100%')
  }

  @Builder TopAppBar() {
    Stack({ alignContent: Alignment.Center }) {
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor(DesignTokens.Colors.surface)
        .opacity(0.95)
        
      Row() {
        Circle({ width: 26, height: 26 })
          .fill(DesignTokens.Colors.surfaceVariant)
        
        Blank()
        
        Column({ space: 2 }) {
          Text('SupplyHub')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(DesignTokens.Colors.onSurface)
          
          Text('Logistics grid')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(DesignTokens.Colors.onSurface)
            .opacity(0.7)
        }
        
        Blank()
        
        Circle({ width: 26, height: 26 })
          .fill(DesignTokens.Colors.surfaceVariant)
      }
      .width('100%')
      .padding({ left: DesignTokens.Spacing.lg, right: DesignTokens.Spacing.lg, top: DesignTokens.Spacing.md, bottom: DesignTokens.Spacing.md })
    }
    .height(64)
  }

  @Builder FilterButtons() {
    Scroll() {
      Row({ space: DesignTokens.Spacing.xs }) {
        ForEach(this.filters, (filter: HubFilter) => {
          Button({ type: ButtonType.Normal, stateEffect: false }) {
            Text(filter.label)
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
              .fontColor(this.activeFilter === filter.label ? DesignTokens.Colors.onSecondary : DesignTokens.Colors.onSurface)
              .padding({ left: DesignTokens.Spacing.sm, right: DesignTokens.Spacing.sm, top: DesignTokens.Spacing.xxs, bottom: DesignTokens.Spacing.xxs })
          }
          .backgroundColor(this.activeFilter === filter.label ? DesignTokens.Colors.secondary : DesignTokens.Colors.surfaceVariant)
          .borderRadius(DesignTokens.CornerRadius.small)
          .onClick(() => {
            this.activeFilter = filter.label;
          })
        })
      }
      .padding({ left: DesignTokens.Spacing.lg, right: DesignTokens.Spacing.lg })
    }
    .scrollable(ScrollDirection.Horizontal)
    .scrollBar(BarState.Off)
  }

  @Builder CargoCardView(card: CargoCard) {
    Column({ space: DesignTokens.Spacing.sm }) {
      // Image placeholder
      Stack({ alignContent: Alignment.Center }) {
        Column()
          .width('100%')
          .height(90)
          .backgroundColor(DesignTokens.Colors.surface)
          .borderRadius(DesignTokens.CornerRadius.small)
          
        Circle({ width: 60, height: 60 })
          .fill(DesignTokens.Colors.tertiary)
          .opacity(0.4)
      }
      .width('100%')
      .height(90)
      
      Column({ space: DesignTokens.Spacing.xxs }) {
        Text(card.title)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(DesignTokens.Colors.onSurface)
        
        Text(card.itemId)
          .fontSize(14)
          .fontWeight(FontWeight.Normal)
          .fontColor(DesignTokens.Colors.onSurface)
          .opacity(0.7)
        
        Text(`Fill ${card.fill}`)
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(DesignTokens.Colors.success)
      }
      .alignItems(HorizontalAlign.Start)
    }
    .padding(DesignTokens.Spacing.md)
    .backgroundColor(DesignTokens.Colors.surfaceVariant)
    .opacity(0.92)
    .borderRadius(DesignTokens.CornerRadius.medium)
    .alignItems(HorizontalAlign.Start)
  }
}