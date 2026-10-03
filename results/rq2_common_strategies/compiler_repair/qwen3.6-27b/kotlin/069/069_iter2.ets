import { window } from '@kit.ArkUI'
import { BusinessError } from '@kit.BasicServicesKit'

// --- Design Tokens & Constants ---

const NAME = "131*SupplyHub*en"
const UI_TYPE = "Grid"
const STYLE_THEME = "Muted Earth"
const LANG = "en"
const BASELINE_SIZE = "720x1280"
const COLOR_PALETTE = "primary:#8B6B4C secondary:#C27D38 tertiary:#F2C57C background:#100C08 surface:#19110D surfaceVariant:#2A1C14 outline:#4F3A2C success:#6ECE89 warning:#E19F41 error:#D96666 onPrimary:#100C08 onSecondary:#100C08 onTertiary:#120E04 onBackground:#F7EAD8 onSurface:#FBEFE0"
const DENSITY_SPACING = "Medium"
const COMPLEXITY = "Grid,Image,LazyList"
const EXTRA = "Muted earth cargo grid with image placeholders"

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

  static Shapes: Record<string, number> = {
    small: 10,
    medium: 18,
    large: 26
  }
}

// --- Data Models ---

interface CargoCard {
  title: string;
  id: string;
  fill: string;
}

interface ManifestEntry {
  origin: string;
  destination: string;
  status: string;
}

interface HubFilter {
  label: string;
}

// --- Main Entry ---

@Entry
@Component
struct RootScreen {
  @State activeFilter: string = 'All';

  // Mock Data
  private cards: CargoCard[] = [
    { title: "Copper stack", id: "SH-014", fill: "78%" },
    { title: "Fiber reels", id: "SH-022", fill: "64%" },
    { title: "Agro crates", id: "SH-031", fill: "92%" },
    { title: "Glass kits", id: "SH-045", fill: "51%" },
    { title: "Steel mesh", id: "SH-057", fill: "88%" },
    { title: "Raw silica", id: "SH-063", fill: "43%" }
  ];

  private manifest: ManifestEntry[] = [
    { origin: "Santiago", destination: "Lima", status: "Boarding" },
    { origin: "Mecca", destination: "Algiers", status: "At dock" },
    { origin: "Reykjavík", destination: "Oslo", status: "Delayed" },
    { origin: "Perth", destination: "Jakarta", status: "In flight" }
  ];

  private filters: HubFilter[] = [
    { label: "All" },
    { label: "Atlantic" },
    { label: "Pacific" },
    { label: "Inland" }
  ];

  aboutToAppear() {
    try {
      let windowClass: window.Window = window.getWindowSync(this.getUIContext().getWindow());
      windowClass.setWindowLayoutFullScreen(true);
      windowClass.setWindowSystemBarEnable([window.SystemBarType.STATUS_BAR, window.SystemBarType.NAVIGATION_BAR], {
        statusBarColor: '#00000000',
        navigationBarColor: '#00000000'
      });
    } catch (e) {
      console.error('Failed to set window properties');
    }
  }

  build() {
    Column() {
      // Top Bar
      Row() {
        // Navigation Icon Placeholder
        Button() {
          Circle({ width: 26, height: 26 })
            .fill(DesignTokens.Colors.surfaceVariant)
        }
        .type(ButtonType.Normal)
        .backgroundColor(Color.Transparent)
        .borderWidth(0)
        .onClick(() => {})

        Column() {
          Text("SupplyHub")
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .letterSpacing(0.2)
            .fontColor(DesignTokens.Colors.onSurface)
          
          Text("Logistics grid")
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .letterSpacing(0.3)
            .fontColor('#B3' + DesignTokens.Colors.onSurface.slice(1)) // 70% opacity approx
        }
        .alignItems(HorizontalAlign.Center)
        .justifyContent(FlexAlign.Center)
        .layoutWeight(1)

        // Action Icon Placeholder
        Button() {
          Circle({ width: 26, height: 26 })
            .fill(DesignTokens.Colors.surfaceVariant)
        }
        .type(ButtonType.Normal)
        .backgroundColor(Color.Transparent)
        .borderWidth(0)
        .onClick(() => {})
      }
      .width('100%')
      .height(60) // Approximate height based on padding and text
      .padding({ left: DesignTokens.Spacing.lg, right: DesignTokens.Spacing.lg })
      .backgroundColor('#F2' + DesignTokens.Colors.surface.slice(1)) // 95% opacity
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)

      // Main Content Scrollable Area
      Scroll() {
        Column() {
          // Filters
          Flex({ wrap: FlexWrap.Wrap, justifyContent: FlexAlign.Start }) {
            ForEach(this.filters, (filter: HubFilter) => {
              Button(filter.label)
                .type(ButtonType.Normal)
                .backgroundColor(this.activeFilter === filter.label 
                  ? DesignTokens.Colors.secondary 
                  : DesignTokens.Colors.surfaceVariant)
                .borderRadius(DesignTokens.Shapes.small)
                .padding({ left: DesignTokens.Spacing.sm, right: DesignTokens.Spacing.sm, top: DesignTokens.Spacing.xxs, bottom: DesignTokens.Spacing.xxs })
                .margin({ right: DesignTokens.Spacing.xs })
                .onClick(() => {
                  this.activeFilter = filter.label;
                })
                .fontColor(this.activeFilter === filter.label 
                  ? DesignTokens.Colors.onSecondary 
                  : DesignTokens.Colors.onSurface)
                .fontSize(12)
                .fontWeight(FontWeight.Medium)
                .letterSpacing(0.3)
            })
          }
          .width('100%')
          .margin({ top: DesignTokens.Spacing.md, bottom: DesignTokens.Spacing.lg })

          // Section Title
          Text("Cargo grid")
            .fontSize(22)
            .fontWeight(FontWeight.Bold)
            .letterSpacing(0.1)
            .fontColor(DesignTokens.Colors.onSurface)
            .margin({ bottom: DesignTokens.Spacing.sm })

          // Grid Layout
          GridContainer() {
            ForEach(this.cards, (card: CargoCard) => {
              GridItem() {
                Column() {
                  // Image Placeholder
                  Row() {
                    Circle({ width: 60, height: 60 })
                      .fill('#66' + DesignTokens.Colors.tertiary.slice(1)) // 40% opacity
                  }
                  .width('100%')
                  .height(90)
                  .backgroundColor(DesignTokens.Colors.surface)
                  .borderRadius(DesignTokens.Shapes.small)
                  .justifyContent(FlexAlign.Center)
                  .alignItems(VerticalAlign.Center)
                  .margin({ bottom: DesignTokens.Spacing.sm })

                  // Text Info
                  Column() {
                    Text(card.title)
                      .fontSize(16)
                      .fontWeight(FontWeight.Medium)
                      .letterSpacing(0.2)
                      .fontColor(DesignTokens.Colors.onSurface)
                    
                    Text(card.id)
                      .fontSize(14)
                      .fontWeight(FontWeight.Normal)
                      .letterSpacing(0.2)
                      .fontColor('#B3' + DesignTokens.Colors.onSurface.slice(1)) // 70% opacity
                      .margin({ top: DesignTokens.Spacing.xxs })

                    Text(`Fill ${card.fill}`)
                      .fontSize(12)
                      .fontWeight(FontWeight.Medium)
                      .letterSpacing(0.3)
                      .fontColor(DesignTokens.Colors.success)
                      .margin({ top: DesignTokens.Spacing.xxs })
                  }
                }
                .width('100%')
                .padding(DesignTokens.Spacing.md)
                .backgroundColor('#EA' + DesignTokens.Colors.surfaceVariant.slice(1)) // 92% opacity
                .borderRadius(DesignTokens.Shapes.medium)
              }
            })
          }
          .columnsTemplate('1fr 1fr')
          .rowsTemplate('auto auto') // Adjusted for 6 items (3 rows)
          .gaps({ row: DesignTokens.Spacing.sm, column: DesignTokens.Spacing.sm })
          .width('100%')
          .margin({ bottom: DesignTokens.Spacing.lg })

          // Section Title
          Text("Route manifest")
            .fontSize(22)
            .fontWeight(FontWeight.Bold)
            .letterSpacing(0.1)
            .fontColor(DesignTokens.Colors.onSurface)
            .margin({ bottom: DesignTokens.Spacing.sm })

          // Manifest List
          ForEach(this.manifest, (entry: ManifestEntry) => {
            Row() {
              Column() {
                Text(`${entry.origin} → ${entry.destination}`)
                  .fontSize(16)
                  .fontWeight(FontWeight.Medium)
                  .letterSpacing(0.2)
                  .fontColor(DesignTokens.Colors.onSurface)
                
                Text(entry.status)
                  .fontSize(14)
                  .fontWeight(FontWeight.Normal)
                  .letterSpacing(0.2)
                  .fontColor(this.getStatusColor(entry.status))
                  .margin({ top: DesignTokens.Spacing.xxs })
              }
              .layoutWeight(1)
              .alignSelf(ItemAlign.Center)

              Button("Details")
                .type(ButtonType.Normal)
                .backgroundColor(DesignTokens.Colors.secondary)
                .borderRadius(DesignTokens.Shapes.small)
                .padding({ left: DesignTokens.Spacing.sm, right: DesignTokens.Spacing.sm, top: DesignTokens.Spacing.xs, bottom: DesignTokens.Spacing.xs })
                .margin({ left: DesignTokens.Spacing.sm })
                .fontColor(DesignTokens.Colors.onSecondary)
                .fontSize(12)
                .fontWeight(FontWeight.Medium)
                .letterSpacing(0.3)
            }
            .width('100%')
            .padding(DesignTokens.Spacing.md)
            .backgroundColor('#D9' + DesignTokens.Colors.surfaceVariant.slice(1)) // 85% opacity
            .borderRadius(DesignTokens.Shapes.medium)
            .margin({ bottom: DesignTokens.Spacing.sm })
            .justifyContent(FlexAlign.SpaceBetween)
            .alignItems(VerticalAlign.Center)
          })
          
          // Bottom Spacer for Bottom Bar
          Blank().height(100)
        }
        .padding({ left: DesignTokens.Spacing.lg, right: DesignTokens.Spacing.lg, top: DesignTokens.Spacing.md })
        .width('100%')
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)

      // Bottom Bar
      Row() {
        Column() {
          Text("Manifest filter")
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .letterSpacing(0.3)
            .fontColor(DesignTokens.Colors.onSurface)
          
          Text(this.activeFilter)
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .letterSpacing(0.2)
            .fontColor(DesignTokens.Colors.onSurface)
            .margin({ top: DesignTokens.Spacing.xxs })
        }
        
        Button("Dispatch")
          .type(ButtonType.Normal)
          .backgroundColor(DesignTokens.Colors.primary)
          .borderRadius(DesignTokens.Shapes.medium)
          .padding({ left: DesignTokens.Spacing.xl, right: DesignTokens.Spacing.xl, top: DesignTokens.Spacing.xs, bottom: DesignTokens.Spacing.xs })
          .margin({ left: DesignTokens.Spacing.sm })
          .fontColor(DesignTokens.Colors.onPrimary)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .letterSpacing(0.2)
      }
      .width('100%')
      .padding({ left: DesignTokens.Spacing.lg, right: DesignTokens.Spacing.lg, top: DesignTokens.Spacing.md, bottom: DesignTokens.Spacing.md })
      .backgroundColor(DesignTokens.Colors.surface)
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(DesignTokens.Colors.background)
  }

  private getStatusColor(status: string): string {
    if (status === "Delayed") return DesignTokens.Colors.warning;
    if (status === "In flight") return DesignTokens.Colors.success;
    return '#CC' + DesignTokens.Colors.onSurface.slice(1); // 80% opacity
  }
}