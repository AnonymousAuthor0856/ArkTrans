import { ChatThread } from '../models/ChatThread';

interface TypographyToken {
  size: string;
  weight: FontWeight;
}

interface ColorsToken {
  onSurface: string;
  secondary: string;
  tertiary: string;
  primary: string;
  surface: string;
  surfaceVariant: string;
  background: string;
  outline: string;
  onSecondary: string;
  onTertiary: string;
  onPrimary: string;
}

interface SpacingToken {
  xs: string;
  sm: string;
  md: string;
  lg: string;
}

interface ShapesToken {
  small: string;
  medium: string;
  large: string;
}

const AppTokens = {
  Typography: {
    label: { size: '14fp', weight: FontWeight.Normal },
    title: { size: '20fp', weight: FontWeight.Medium },
    headline: { size: '24fp', weight: FontWeight.Bold },
    body: { size: '16fp', weight: FontWeight.Normal },
    display: { size: '32fp', weight: FontWeight.Bold }
  } as Record<string, TypographyToken>,
  Colors: {
    onSurface: '#FFFFFF',
    secondary: '#FF00FF',
    tertiary: '#00FFFF',
    primary: '#9D00FF',
    surface: '#1E1E1E',
    surfaceVariant: '#2C2C2C',
    background: '#121212',
    outline: '#444444',
    onSecondary: '#000000',
    onTertiary: '#000000',
    onPrimary: '#FFFFFF'
  } as ColorsToken,
  Spacing: {
    xs: '4vp',
    sm: '8vp',
    md: '16vp',
    lg: '24vp'
  } as SpacingToken,
  Shapes: {
    small: '8vp',
    medium: '12vp',
    large: '16vp'
  } as ShapesToken
};

@Component
export struct CustomTopBar {
  build() {
    Row() {
      Button('Hub')
        .fontSize(AppTokens.Typography.label.size)
        .fontWeight(AppTokens.Typography.label.weight)
        .fontColor(AppTokens.Colors.onSurface)
        .backgroundColor(Color.Transparent)
        .borderWidth(0)
      
      Blank()
      
      Column() {
        Text('HoloChat Dock')
          .fontSize(AppTokens.Typography.title.size)
          .fontWeight(AppTokens.Typography.title.weight)
          .fontColor(AppTokens.Colors.onSurface)
        
        Text('Dark neon bridge')
          .fontSize(AppTokens.Typography.label.size)
          .fontWeight(AppTokens.Typography.label.weight)
          .fontColor(AppTokens.Colors.onSurface)
          .opacity(0.7)
      }
      .alignItems(HorizontalAlign.Start)
      
      Blank()
      
      Button('Status')
        .fontSize(AppTokens.Typography.label.size)
        .fontWeight(AppTokens.Typography.label.weight)
        .fontColor(AppTokens.Colors.secondary)
        .backgroundColor(Color.Transparent)
        .borderWidth(0)
    }
    .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.sm })
    .backgroundColor(AppTokens.Colors.surface)
    .width('100%')
  }
}

@Component
export struct AssistChip {
  @Prop label: string;
  @Prop isSelected: boolean;
  action: () => void = () => {};

  build() {
    Button(this.label)
      .fontSize(AppTokens.Typography.label.size)
      .fontWeight(AppTokens.Typography.label.weight)
      .fontColor(this.isSelected ? AppTokens.Colors.onSecondary : AppTokens.Colors.onSurface)
      .backgroundColor(this.isSelected ? AppTokens.Colors.secondary : AppTokens.Colors.surfaceVariant)
      .borderWidth(this.isSelected ? 0 : 1)
      .borderColor(AppTokens.Colors.outline)
      .borderRadius(AppTokens.Shapes.small)
      .onClick(() => {
        this.action();
      })
  }
}

@Component
export struct SummaryBlock {
  @Prop title: string;
  @Prop value: string;
  @Prop accent: string;

  build() {
    Column() {
      Circle()
        .fill(this.accent)
        .width(12)
        .height(12)
      
      Text(this.title.toUpperCase())
        .fontSize(AppTokens.Typography.label.size)
        .fontWeight(AppTokens.Typography.label.weight)
        .fontColor(AppTokens.Colors.onSurface)
        .opacity(0.7)
        .margin({ top: AppTokens.Spacing.xs })
      
      Text(this.value)
        .fontSize(AppTokens.Typography.display.size)
        .fontWeight(AppTokens.Typography.display.weight)
        .fontColor(this.accent)
    }
    .alignItems(HorizontalAlign.Start)
    .padding(AppTokens.Spacing.md)
    .layoutWeight(1)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.medium)
  }
}

@Component
export struct StatusSummary {
  build() {
    Row() {
      SummaryBlock({ title: 'Live docks', value: '12', accent: AppTokens.Colors.secondary })
      SummaryBlock({ title: 'Escalations', value: '3', accent: AppTokens.Colors.tertiary })
      SummaryBlock({ title: 'Queued', value: '5', accent: AppTokens.Colors.primary })
    }
    .margin({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
    .columnGap(AppTokens.Spacing.sm)
  }
}

@Component
export struct ChatThreadCard {
  @Prop thread: ChatThread;

  build() {
    Column() {
      Row() {
        Column() {
          Text(this.thread.name)
            .fontSize(AppTokens.Typography.headline.size)
            .fontWeight(AppTokens.Typography.headline.weight)
            .fontColor(AppTokens.Colors.onSurface)
          
          Text(this.thread.status)
            .fontSize(AppTokens.Typography.label.size)
            .fontWeight(AppTokens.Typography.label.weight)
            .fontColor(this.thread.isPriority ? AppTokens.Colors.secondary : AppTokens.Colors.onSurface)
            .opacity(this.thread.isPriority ? 1 : 0.7)
            .margin({ top: AppTokens.Spacing.xs })
        }
        .alignItems(HorizontalAlign.Start)
        
        Blank()
        
        Text(this.thread.unread > 0 ? `+${this.thread.unread}` : '✓')
          .fontSize(AppTokens.Typography.label.size)
          .fontWeight(AppTokens.Typography.label.weight)
          .fontColor(AppTokens.Colors.onSurface)
          .padding({ left: AppTokens.Spacing.sm, right: AppTokens.Spacing.sm, top: AppTokens.Spacing.xs, bottom: AppTokens.Spacing.xs })
          .backgroundColor(AppTokens.Colors.surfaceVariant)
          .borderRadius(AppTokens.Shapes.small)
      }
      
      Text(this.thread.snippet)
        .fontSize(AppTokens.Typography.body.size)
        .fontWeight(AppTokens.Typography.body.weight)
        .fontColor(AppTokens.Colors.onSurface)
        .opacity(0.9)
        .margin({ top: AppTokens.Spacing.sm })
      
      Row() {
        Text(this.thread.isPriority ? 'Priority' : 'Standard')
          .fontSize(AppTokens.Typography.label.size)
          .fontWeight(AppTokens.Typography.label.weight)
          .fontColor(AppTokens.Colors.onSurface)
          .padding({ left: AppTokens.Spacing.sm, right: AppTokens.Spacing.sm, top: AppTokens.Spacing.xs, bottom: AppTokens.Spacing.xs })
          .backgroundColor(AppTokens.Colors.surfaceVariant)
          .borderRadius(AppTokens.Shapes.small)
        
        Button('Open')
          .fontSize(AppTokens.Typography.label.size)
          .fontWeight(AppTokens.Typography.label.weight)
          .fontColor(AppTokens.Colors.secondary)
          .backgroundColor(Color.Transparent)
          .borderWidth(0)
          .margin({ left: AppTokens.Spacing.sm })
      }
      .margin({ top: AppTokens.Spacing.sm })
    }
    .alignItems(HorizontalAlign.Start)
    .padding(AppTokens.Spacing.md)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.large)
    .border({ width: 1, color: AppTokens.Colors.outline })
    .margin({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, bottom: AppTokens.Spacing.md })
  }
}

@Component
export struct ActionFooter {
  build() {
    Column() {
      Text('Dock filters')
        .fontSize(AppTokens.Typography.title.size)
        .fontWeight(AppTokens.Typography.title.weight)
        .fontColor(AppTokens.Colors.onSurface)
      
      Row() {
        Button('Calm')
          .fontSize(AppTokens.Typography.label.size)
          .fontWeight(AppTokens.Typography.label.weight)
          .fontColor(AppTokens.Colors.onPrimary)
          .backgroundColor(AppTokens.Colors.primary)
          .borderRadius(AppTokens.Shapes.medium)
          .padding({ left: 16, right: 16, top: 10, bottom: 10 })
        
        Button('Fire')
          .fontSize(AppTokens.Typography.label.size)
          .fontWeight(AppTokens.Typography.label.weight)
          .fontColor(AppTokens.Colors.onTertiary)
          .backgroundColor(AppTokens.Colors.tertiary)
          .borderRadius(AppTokens.Shapes.medium)
          .padding({ left: 16, right: 16, top: 10, bottom: 10 })
          .margin({ left: AppTokens.Spacing.sm })
      }
      .margin({ top: AppTokens.Spacing.sm })
    }
    .alignItems(HorizontalAlign.Start)
    .padding(AppTokens.Spacing.lg)
    .backgroundColor(AppTokens.Colors.surfaceVariant)
    .borderRadius(AppTokens.Shapes.large)
    .margin({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, bottom: AppTokens.Spacing.md })
  }
}

@Component
export struct BottomInputBar {
  @Link text: string;

  build() {
    Row() {
      TextInput({ placeholder: 'Message dock...' })
        .fontSize(AppTokens.Typography.body.size)
        .fontWeight(AppTokens.Typography.body.weight)
        .fontColor(AppTokens.Colors.onSurface)
        .placeholderColor(AppTokens.Colors.onSurface)
        .backgroundColor(AppTokens.Colors.surface)
        .borderRadius(AppTokens.Shapes.medium)
        .height(48)
        .layoutWeight(1)
        .margin({ right: AppTokens.Spacing.sm })
        .onChange((value: string) => {
          this.text = value;
        })
      
      Button('Send')
        .fontSize(AppTokens.Typography.label.size)
        .fontWeight(AppTokens.Typography.label.weight)
        .fontColor(AppTokens.Colors.onPrimary)
        .backgroundColor(AppTokens.Colors.primary)
        .borderRadius(AppTokens.Shapes.medium)
        .height(48)
        .padding({ left: 20, right: 20 })
    }
    .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.sm })
    .backgroundColor(AppTokens.Colors.surfaceVariant)
    .shadow({ radius: 6, color: '#00000033', offsetY: -2 })
  }
}

@Entry
@Component
struct HoloChatDockScreen {
  @State activeFilter: string = 'Live';
  @State draftMessage: string = '';
  
  private filters: string[] = ['Live', 'Pinned', 'Escalated', 'Silent'];
  private threads: ChatThread[] = [
    { id: '1', name: 'Orbital Finance', status: 'Rolling sync', unread: 5, snippet: 'Need rates for Q4', isPriority: true },
    { id: '2', name: 'Beacon Ops', status: 'Docked', unread: 0, snippet: 'Switching to holo feed', isPriority: false },
    { id: '3', name: 'Nova Crew', status: 'Hotline', unread: 2, snippet: 'Uploading scan pack now', isPriority: true }
  ];

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Column() {
        CustomTopBar()
        
        Scroll() {
          Column() {
            // Filters
            Scroll() {
              Row() {
                ForEach(this.filters, (filter: string) => {
                  AssistChip({ 
                    label: filter, 
                    isSelected: this.activeFilter === filter 
                  })
                    .onClick(() => {
                      this.activeFilter = filter;
                    })
                    .margin({ right: AppTokens.Spacing.sm })
                })
              }
              .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
            }
            .scrollable(ScrollDirection.Horizontal)
            .width('100%')
            
            StatusSummary()
            
            // Threads List
            ForEach(this.threads, (thread: ChatThread) => {
              ChatThreadCard({ thread: thread })
            })
            
            ActionFooter()
            
            // Spacer for bottom bar + FAB area
            Blank().height(100)
          }
          .padding({ top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.md })
        }
        .layoutWeight(1)
      }
      .backgroundColor(AppTokens.Colors.background)
      
      // FAB (Floating Action Button) overlay
      Column() {
        Blank()
        Row() {
          Blank()
          Button('New')
            .fontSize(AppTokens.Typography.label.size)
            .fontWeight(AppTokens.Typography.label.weight)
            .fontColor(AppTokens.Colors.onPrimary)
            .backgroundColor(AppTokens.Colors.primary)
            .borderRadius(AppTokens.Shapes.medium)
            .padding({ left: 16, right: 16, top: 16, bottom: 16 })
            .shadow({ radius: 4, color: '#00000033' })
            .margin({ right: AppTokens.Spacing.lg, bottom: 80 })
        }
      }
      .width('100%')
      .height('100%')
      
      // Bottom Bar
      BottomInputBar({ text: $draftMessage })
    }
    .backgroundColor(AppTokens.Colors.background)
  }
}