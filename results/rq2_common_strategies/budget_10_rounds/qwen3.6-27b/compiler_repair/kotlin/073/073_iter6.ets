import { router } from '@kit.ArkRouter'
import { window } from '@kit.ArkUI'

// --- Design Tokens & Constants ---

interface AppTokensColors {
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

interface AppTokensSpacing {
  xs: number;
  sm: number;
  md: number;
  lg: number;
  xl: number;
  xxl: number;
  xxxl: number;
}

interface AppTokensShapes {
  small: number;
  medium: number;
  large: number;
}

interface AppTokensInterface {
  Colors: AppTokensColors;
  Spacing: AppTokensSpacing;
  Shapes: AppTokensShapes;
}

const AppTokens: AppTokensInterface = {
  Colors: {
    primary: '#7C3AED',
    secondary: '#22D3EE',
    tertiary: '#F97316',
    background: '#050714',
    surface: '#0F172A',
    surfaceVariant: '#1F2937',
    outline: '#334155',
    success: '#34D399',
    warning: '#FBBF24',
    error: '#F87171',
    onPrimary: '#050714',
    onSecondary: '#011014',
    onTertiary: '#110200',
    onBackground: '#F8FAFC',
    onSurface: '#E2E8F0'
  },
  Spacing: {
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
    xxl: 32,
    xxxl: 44
  },
  Shapes: {
    small: 12,
    medium: 16,
    large: 20
  }
}

interface ChatThread {
  name: string;
  status: string;
  unread: number;
  snippet: string;
  isPriority: boolean;
}

@Entry
@Component
struct RootScreen {
  @State activeFilter: string = 'Live';
  @State draftText: string = '';
  
  private filters: string[] = ['Live', 'Pinned', 'Escalated', 'Silent'];
  
  private threads: ChatThread[] = [
    { name: "Orbital Finance", status: "Rolling sync", unread: 5, snippet: "Need rates for Q4", isPriority: true },
    { name: "Beacon Ops", status: "Docked", unread: 0, snippet: "Switching to holo feed", isPriority: false },
    { name: "Nova Crew", status: "Hotline", unread: 2, snippet: "Uploading scan pack now", isPriority: true }
  ];

  aboutToAppear() {
    // Hide system bars for immersive experience similar to the Kotlin code
    let windowClass: window.Window | null = null;
    try {
      windowClass = window.getWindowSync(this);
      if (windowClass) {
        windowClass.setWindowSystemBarEnable([], (err) => {
          if (err) {
            console.error(`Failed to set system bar enable. Code is ${err.code}, message is ${err.message}`);
          }
        });
      }
    } catch (e) {
      console.error('Window access error');
    }
  }

  build() {
    Column() {
      // Top Bar
      Row() {
        TextButton({ title: 'Hub' })
        
        Column() {
          Text('HoloChat Dock')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppTokens.Colors.onSurface)
          
          Text('Dark neon bridge')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(Color('#E2E8F0').withOpacity(0.7))
        }
        
        Flex({ justifyContent: FlexAlign.End, alignItems: ItemAlign.Center }) {
           TextButton({ title: 'Status', color: AppTokens.Colors.secondary })
        }
      }
      .width('100%')
      .height(60)
      .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
      .backgroundColor(AppTokens.Colors.surface)
      .alignItems(VerticalAlign.Center)

      // Scrollable Content Area
      Scroll() {
        Column() {
          // Filter Chips
          Flex({ wrap: FlexWrap.Wrap, justifyContent: FlexAlign.Start }) {
            ForEach(this.filters, (label: string) => {
              ChipButton({ 
                label: label, 
                isActive: this.activeFilter === label, 
                onClick: () => { this.activeFilter = label } 
              })
            })
          }
          .width('100%')
          .margin({ top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.md })
          .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
          .gap(AppTokens.Spacing.sm)

          // Status Summary
          StatusSummary()
            .margin({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, bottom: AppTokens.Spacing.md })

          // Thread List
          ForEach(this.threads, (thread: ChatThread) => {
            ChatThreadCard({ thread: thread })
              .margin({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, bottom: AppTokens.Spacing.md })
          })

          // Action Footer
          ActionFooter()
            .margin({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, bottom: AppTokens.Spacing.xxl })
        }
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)

      // Bottom Input Bar
      Surface({ color: AppTokens.Colors.surfaceVariant }) {
        Row() {
          TextInput({ placeholder: 'Message dock...', text: $draftText })
            .layoutWeight(1)
            .backgroundColor(AppTokens.Colors.surface)
            .borderRadius(AppTokens.Shapes.medium)
            .padding({ left: AppTokens.Spacing.md, right: AppTokens.Spacing.md })
            .height(44)
            .margin({ right: AppTokens.Spacing.sm })
            .fontColor(AppTokens.Colors.onSurface)
            .type(InputType.Normal)
            .placeholderColor(Color('#E2E8F0').withOpacity(0.6))
            .border({ width: 0 })
            
          Button('Send')
            .backgroundColor(AppTokens.Colors.primary)
            .fontColor(AppTokens.Colors.onPrimary)
            .borderRadius(AppTokens.Shapes.medium)
            .height(44)
            .width(80)
        }
        .width('100%')
        .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.sm })
        .alignItems(VerticalAlign.Center)
      }
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}

// --- Sub-Components ---

@Component
struct TextButton {
  @Prop title: string;
  @Prop color?: string;

  build() {
    Text(this.title)
      .fontSize(12)
      .fontWeight(FontWeight.Medium)
      .fontColor(this.color ? this.color : AppTokens.Colors.onSurface)
      .onClick(() => {})
  }
}

@Component
struct ChipButton {
  @Prop label: string;
  @Prop isActive: boolean;
  @Prop onClick: () => void;

  build() {
    Button(this.label)
      .backgroundColor(this.isActive ? AppTokens.Colors.secondary : AppTokens.Colors.surfaceVariant)
      .fontColor(this.isActive ? AppTokens.Colors.onSecondary : AppTokens.Colors.onSurface)
      .borderRadius(AppTokens.Shapes.small)
      .height(32)
      .margin({ right: AppTokens.Spacing.sm })
      .onClick(() => {
        this.onClick();
      })
      .border({ width: 0 })
  }
}

@Component
struct StatusSummary {
  build() {
    Row() {
      SummaryBlock({ title: "Live docks", value: "12", accent: AppTokens.Colors.secondary })
      SummaryBlock({ title: "Escalations", value: "3", accent: AppTokens.Colors.tertiary })
      SummaryBlock({ title: "Queued", value: "5", accent: AppTokens.Colors.primary })
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
  }
}

@Component
struct SummaryBlock {
  @Prop title: string;
  @Prop value: string;
  @Prop accent: string;

  build() {
    Column() {
      Circle({ width: 12, height: 12 })
        .fill(this.accent)
      
      Text(this.title.toUpperCase())
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(Color('#E2E8F0').withOpacity(0.7))
        .margin({ top: AppTokens.Spacing.xs })
      
      Text(this.value)
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .lineHeight(34)
        .fontColor(this.accent)
    }
    .width('32%')
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.medium)
    .padding(AppTokens.Spacing.md)
    .alignItems(HorizontalAlign.Center)
  }
}

@Component
struct ChatThreadCard {
  @Prop thread: ChatThread;

  build() {
    Column() {
      Row() {
        Column() {
          Text(this.thread.name)
            .fontSize(22)
            .fontWeight(FontWeight.Medium)
            .lineHeight(28)
            .fontColor(AppTokens.Colors.onSurface)
          
          Text(this.thread.status)
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.thread.isPriority ? AppTokens.Colors.secondary : Color('#E2E8F0').withOpacity(0.7))
            .margin({ top: AppTokens.Spacing.xs })
        }
        
        Flex({ justifyContent: FlexAlign.End }) {
          Text(this.thread.unread > 0 ? `+${this.thread.unread}` : '✓')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppTokens.Colors.onSurface)
            .backgroundColor(AppTokens.Colors.surfaceVariant)
            .borderRadius(AppTokens.Shapes.small)
            .padding({ left: AppTokens.Spacing.sm, right: AppTokens.Spacing.sm, top: AppTokens.Spacing.xs, bottom: AppTokens.Spacing.xs })
        }
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)

      Text(this.thread.snippet)
        .fontSize(14)
        .fontWeight(FontWeight.Normal)
        .lineHeight(20)
        .fontColor(Color('#E2E8F0').withOpacity(0.9))
        .margin({ top: AppTokens.Spacing.sm })

      Row() {
        Text(this.thread.isPriority ? 'Priority' : 'Standard')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onSurface)
          .backgroundColor(AppTokens.Colors.surfaceVariant)
          .borderRadius(AppTokens.Shapes.small)
          .padding({ left: AppTokens.Spacing.sm, right: AppTokens.Spacing.sm, top: AppTokens.Spacing.xs, bottom: AppTokens.Spacing.xs })
          .margin({ right: AppTokens.Spacing.sm })

        TextButton({ title: 'Open', color: AppTokens.Colors.secondary })
      }
      .margin({ top: AppTokens.Spacing.sm })
    }
    .width('100%')
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.large)
    .border({ width: 1, color: AppTokens.Colors.outline })
    .shadow({ radius: 6, color: Color.Black.withOpacity(0.14), offsetY: 2 })
    .padding(AppTokens.Spacing.md)
  }
}

@Component
struct ActionFooter {
  build() {
    Column() {
      Text('Dock filters')
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .lineHeight(22)
        .fontColor(AppTokens.Colors.onSurface)
      
      Row() {
        Button('Calm')
          .backgroundColor(AppTokens.Colors.primary)
          .fontColor(AppTokens.Colors.onPrimary)
          .borderRadius(AppTokens.Shapes.medium)
          .height(40)
          .flexShrink(1)
          .margin({ right: AppTokens.Spacing.sm })
        
        Button('Fire')
          .backgroundColor(AppTokens.Colors.tertiary)
          .fontColor(AppTokens.Colors.onTertiary)
          .borderRadius(AppTokens.Shapes.medium)
          .height(40)
          .flexShrink(1)
      }
      .margin({ top: AppTokens.Spacing.sm })
    }
    .width('100%')
    .backgroundColor(AppTokens.Colors.surfaceVariant)
    .borderRadius(AppTokens.Shapes.large)
    .padding(AppTokens.Spacing.lg)
  }
}

@Component
struct Surface {
  @Prop color: string;
  @BuilderParam child: () => void;

  build() {
    Column() {
      this.child()
    }
    .width('100%')
    .backgroundColor(this.color)
  }
}