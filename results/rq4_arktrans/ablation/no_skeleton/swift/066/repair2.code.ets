@Entry
@Component
struct StockCalendarApp {
  @State selectedDayId: number = 1
  @State currentSector: string = 'All'

  // Data Models
  private days: DayItem[] = [
    { id: 1, label: 'Mon' },
    { id: 2, label: 'Tue' },
    { id: 3, label: 'Wed' },
    { id: 4, label: 'Thu' },
    { id: 5, label: 'Fri' }
  ]

  private sectors: string[] = ['All', 'Tech', 'Energy', 'Finance']

  private items: StockItem[] = [
    { code: '600519', name: 'Kweichow Moutai', price: '1687.3', change: '+1.24%', positive: true },
    { code: '000001', name: 'Ping An Bank', price: '12.54', change: '-0.62%', positive: false },
    { code: '300750', name: 'CATL', price: '192.8', change: '+0.87%', positive: true },
    { code: '601318', name: 'Ping An Ins.', price: '44.2', change: '-1.12%', positive: false },
    { code: '600036', name: 'CMBC', price: '36.9', change: '+0.15%', positive: true },
    { code: '688981', name: 'SMIC', price: '56.4', change: '-0.48%', positive: false }
  ]

  // Design Tokens (Colors)
  private colors: ColorTokens = {
    primary: '#214E34',
    secondary: '#2D6A4F',
    tertiary: '#6C757D',
    background: '#F8F1E5',
    surface: '#FFFBF0',
    surfaceVariant: '#E9DFC7',
    outline: '#D2C6AA',
    success: '#2B9348',
    warning: '#F4A261',
    error: '#D62828',
    onPrimary: '#FFFFFF',
    onSecondary: '#FFFFFF',
    onTertiary: '#1B1F22',
    onBackground: '#1B1F22',
    onSurface: '#1B1F22'
  }

  build() {
    Stack() {
      // Background
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor(this.colors.background)

      Column() {
        // Top Bar
        Row() {
          Text('Stock Calendar')
            .fontSize(26)
            .fontWeight(FontWeight.Bold)
            .fontColor(this.colors.onSurface)
        }
        .width('100%')
        .justifyContent(FlexAlign.Center)
        .padding({ top: 40, bottom: 40 })

        // Scrollable Content
        Scroll() {
          Column({ space: 12 }) {
            // Filter Card
            Column({ space: 12 }) {
              // Day Tabs
              Row({ space: 12 }) {
                ForEach(this.days, (day: DayItem) => {
                  Button(day.label)
                    .type(ButtonType.Normal)
                    .onClick(() => {
                      this.selectedDayId = day.id
                    })
                    .backgroundColor(this.selectedDayId === day.id ? this.colors.primary : this.colors.surfaceVariant)
                    .fontColor(this.selectedDayId === day.id ? this.colors.onPrimary : this.colors.onSurface)
                    .fontSize(this.selectedDayId === day.id ? 16 : 13)
                    .fontWeight(this.selectedDayId === day.id ? FontWeight.Medium : FontWeight.Regular)
                    .borderRadius(6)
                    .height(36)
                    .layoutWeight(1)
                })
              }

              // Sector Chips
              Row({ space: 8 }) {
                ForEach(this.sectors, (sector: string) => {
                  Button(sector)
                    .type(ButtonType.Normal)
                    .onClick(() => {
                      this.currentSector = sector
                    })
                    .backgroundColor(this.currentSector === sector ? this.colors.secondary : this.colors.surface)
                    .fontColor(this.currentSector === sector ? this.colors.onSecondary : this.colors.onSurface)
                    .fontSize(11)
                    .fontWeight(FontWeight.Medium)
                    .borderRadius(6)
                    .border({ width: 1, color: this.colors.outline })
                    .padding({ left: 12, right: 12, top: 8, bottom: 8 })
                })
              }
            }
            .width('100%')
            .padding(12)
            .backgroundColor(this.colors.surface)
            .borderRadius(14)
            .shadow({ radius: 6, color: '#24000000', offsetY: 3 }) // Level 2 Shadow approx
            .border({ width: 1, color: this.colors.outline })

            // Stock List
            Column({ space: 8 }) {
              ForEach(this.items, (item: StockItem) => {
                Row({ space: 12 }) {
                  // Icon Placeholder
                  Rect()
                    .width(28)
                    .height(28)
                    .borderRadius(6)
                    .fill(Color.Transparent) // Using transparent to match screenshot style if needed, or surfaceVariant
                    .backgroundColor(this.colors.surfaceVariant)

                  // Info
                  Column({ space: 4 }) {
                    Text(item.name)
                      .fontSize(16)
                      .fontWeight(FontWeight.Medium)
                      .fontColor(this.colors.onSurface)
                    
                    Text(item.code)
                      .fontSize(11)
                      .fontWeight(FontWeight.Medium)
                      .fontColor(this.colors.onSurface)
                  }
                  .alignItems(HorizontalAlign.Start)

                  Blank()

                  // Price & Change
                  Column({ space: 4 }) {
                    Text(item.price)
                      .fontSize(16)
                      .fontWeight(FontWeight.Medium)
                      .fontColor(this.colors.onSurface)
                    
                    Row({ space: 4 }) {
                      Circle()
                        .width(8)
                        .height(8)
                        .fill(item.positive ? this.colors.success : this.colors.error)
                      
                      Text(item.change)
                        .fontSize(11)
                        .fontWeight(FontWeight.Medium)
                        .fontColor(item.positive ? this.colors.success : this.colors.error)
                    }
                  }
                  .alignItems(HorizontalAlign.End)

                  // Detail Button
                  Button('Detail')
                    .type(ButtonType.Normal)
                    .backgroundColor(this.colors.primary)
                    .fontColor(this.colors.onPrimary)
                    .fontSize(11)
                    .fontWeight(FontWeight.Medium)
                    .borderRadius(6)
                    .width(76)
                    .height(36)
                }
                .width('100%')
                .padding(12)
                .height(72)
                .backgroundColor(this.colors.surface)
                .borderRadius(10)
                .shadow({ radius: 3, color: '#1A000000', offsetY: 1 }) // Level 1 Shadow approx
                .border({ width: 1, color: this.colors.outline })
              })
            }
          }
          .padding({ left: 16, right: 16, top: 12, bottom: 40 })
        }
        .layoutWeight(1)
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
  }
}

interface DayItem {
  id: number;
  label: string;
}

interface StockItem {
  code: string;
  name: string;
  price: string;
  change: string;
  positive: boolean;
}

interface ColorTokens {
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