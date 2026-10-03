import { Color, FontSize, FontWeight } from '@kit.ArkUI';

// MARK: - App Tokens & Colors
const AppTokens = {
  Colors: {
    primary: '#7C3AED',
    secondary: '#22D3EE',
    tertiary: '#F97316',
    background: '#050714',
    surface: '#0F172A',
    surfaceVariant: '#1F2937',
    outline: '#334155',
    onPrimary: '#050714',
    onSecondary: '#011014',
    onTertiary: '#110200',
    onBackground: '#F8FAFC',
    onSurface: '#E2E8F0'
  },
  Typography: {
    display: { size: 28, weight: FontWeight.Semibold },
    headline: { size: 22, weight: FontWeight.Medium },
    title: { size: 16, weight: FontWeight.Medium },
    body: { size: 14, weight: FontWeight.Regular },
    label: { size: 12, weight: FontWeight.Medium }
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
};

// MARK: - Models
interface ChatThread {
  id: number;
  name: string;
  status: string;
  unread: number;
  snippet: string;
  isPriority: boolean;
}

@Entry
@Component
struct HoloChatApp {
  @State activeFilter: string = "Live";
  @State draftMessage: string = "";

  private filters: string[] = ["Live", "Pinned", "Escalated", "Silent"];
  private threads: ChatThread[] = [
    { id: 1, name: "Orbital Finance", status: "Rolling sync", unread: 5, snippet: "Need rates for Q4", isPriority: true },
    { id: 2, name: "Beacon Ops", status: "Docked", unread: 0, snippet: "Switching to holo feed", isPriority: false },
    { id: 3, name: "Nova Crew", status: "Hotline", unread: 2, snippet: "Uploading scan pack now", isPriority: true }
  ];

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      // Background
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor(AppTokens.Colors.background)

      Column() {
        CustomTopBar()
        
        Scroll() {
          Column({ space: AppTokens.Spacing.md }) {
            // Filters
            Row() {
              ForEach(this.filters, (filter: string) => {
                AssistChip(
                  label: filter,
                  isSelected: this.activeFilter === filter,
                  action: () => { this.activeFilter = filter }
                )
              }, (item: string) => item)
            }
            .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
            .width('100%')
            
            StatusSummary()
              .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })

            ForEach(this.threads, (thread: ChatThread) => {
              ChatThreadCard(thread: thread)
                .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
            }, (item: ChatThread) => item.id.toString())

            ActionFooter()
              .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })

            // Spacer for bottom bar + FAB area
            Column().height(100)
          }
          .padding({ top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.md })
          .width('100%')
        }
        .layoutWeight(1)
        .scrollBar(BarState.Off)
      }
      .width('100%')
      .height('100%')

      // FAB (Floating Action Button) overlay
      Column() {
        Blank()
        Row() {
          Blank()
          Button("New")
            .font({ ...AppTokens.Typography.label })
            .fontColor(AppTokens.Colors.onPrimary)
            .backgroundColor(AppTokens.Colors.primary)
            .borderRadius(AppTokens.Shapes.medium)
            .shadow({ radius: 4, color: '#00000066', offsetY: 2 })
            .margin({ right: AppTokens.Spacing.lg, bottom: 80 })
        }
        .width('100%')
      }
      .width('100%')
      .height('100%')

      BottomInputBar({ text: $draftMessage })
    }
    .width('100%')
    .height('100%')
    .systemBarProperties({ statusBarColor: AppTokens.Colors.background })
  }
}

@Component
struct CustomTopBar {
  build() {
    Row() {
      Text("Hub")
        .font({ ...AppTokens.Typography.label })
        .fontColor(AppTokens.Colors.onSurface)
      
      Blank()
      
      Column({ alignH: HorizontalAlign.Start }) {
        Text("HoloChat Dock")
          .font({ ...AppTokens.Typography.title })
          .fontColor(AppTokens.Colors.onSurface)
        Text("Dark neon bridge")
          .font({ ...AppTokens.Typography.label })
          .fontColor(Color(AppTokens.Colors.onSurface).withOpacity(0.7))
      }
      
      Blank()
      
      Text("Status")
        .font({ ...AppTokens.Typography.label })
        .fontColor(AppTokens.Colors.secondary)
    }
    .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.sm })
    .backgroundColor(AppTokens.Colors.surface)
    .width('100%')
  }
}

@Component
struct AssistChip {
  label: string;
  isSelected: boolean;
  action: () => void;

  build() {
    Button(this.label) {
      Text(this.label)
        .font({ ...AppTokens.Typography.label })
        .fontColor(this.isSelected ? AppTokens.Colors.onSecondary : AppTokens.Colors.onSurface)
    }
    .backgroundColor(this.isSelected ? AppTokens.Colors.secondary : AppTokens.Colors.surfaceVariant)
    .borderWidth(this.isSelected ? 0 : 1)
    .borderColor(AppTokens.Colors.outline)
    .borderRadius(AppTokens.Shapes.small)
    .onClick(() => {
      this.action();
    })
    .margin({ right: AppTokens.Spacing.sm })
  }
}

@Component
struct StatusSummary {
  build() {
    Row({ space: AppTokens.Spacing.sm }) {
      SummaryBlock(title: "Live docks", value: "12", accent: AppTokens.Colors.secondary)
      SummaryBlock(title: "Escalations", value: "3", accent: AppTokens.Colors.tertiary)
      SummaryBlock(title: "Queued", value: "5", accent: AppTokens.Colors.primary)
    }
    .width('100%')
  }
}

@Component
struct SummaryBlock {
  title: string;
  value: string;
  accent: string;

  build() {
    Column({ space: AppTokens.Spacing.xs, alignH: HorizontalAlign.Start }) {
      Circle()
        .fill(this.accent)
        .width(12)
        .height(12)
      
      Text(this.title.toUpperCase())
        .font({ ...AppTokens.Typography.label })
        .fontColor(Color(AppTokens.Colors.onSurface).withOpacity(0.7))
      
      Text(this.value)
        .font({ ...AppTokens.Typography.display })
        .fontColor(this.accent)
    }
    .padding(AppTokens.Spacing.md)
    .flexShrink(1)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.medium)
  }
}

@Component
struct ChatThreadCard {
  thread: ChatThread;

  build() {
    Column({ space: AppTokens.Spacing.sm, alignH: HorizontalAlign.Start }) {
      Row() {
        Column({ space: AppTokens.Spacing.xs, alignH: HorizontalAlign.Start }) {
          Text(this.thread.name)
            .font({ ...AppTokens.Typography.headline })
            .fontColor(AppTokens.Colors.onSurface)
          
          Text(this.thread.status)
            .font({ ...AppTokens.Typography.label })
            .fontColor(this.thread.isPriority ? AppTokens.Colors.secondary : Color(AppTokens.Colors.onSurface).withOpacity(0.7))
        }
        
        Blank()
        
        Text(this.thread.unread > 0 ? `+${this.thread.unread}` : "✓")
          .font({ ...AppTokens.Typography.label })
          .fontColor(AppTokens.Colors.onSurface)
          .padding({ left: AppTokens.Spacing.sm, right: AppTokens.Spacing.sm, top: AppTokens.Spacing.xs, bottom: AppTokens.Spacing.xs })
          .backgroundColor(AppTokens.Colors.surfaceVariant)
          .borderRadius(AppTokens.Shapes.small)
      }
      
      Text(this.thread.snippet)
        .font({ ...AppTokens.Typography.body })
        .fontColor(Color(AppTokens.Colors.onSurface).withOpacity(0.9))
      
      Row({ space: AppTokens.Spacing.sm }) {
        Text(this.thread.isPriority ? "Priority" : "Standard")
          .font({ ...AppTokens.Typography.label })
          .fontColor(AppTokens.Colors.onSurface)
          .padding({ left: AppTokens.Spacing.sm, right: AppTokens.Spacing.sm, top: AppTokens.Spacing.xs, bottom: AppTokens.Spacing.xs })
          .backgroundColor(AppTokens.Colors.surfaceVariant)
          .borderRadius(AppTokens.Shapes.small)
        
        Button("Open")
          .font({ ...AppTokens.Typography.label })
          .fontColor(AppTokens.Colors.secondary)
          .backgroundColor(Transparent)
      }
    }
    .padding(AppTokens.Spacing.md)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.large)
    .borderWidth(1)
    .borderColor(AppTokens.Colors.outline)
  }
}

@Component
struct ActionFooter {
  build() {
    Column({ space: AppTokens.Spacing.sm, alignH: HorizontalAlign.Start }) {
      Text("Dock filters")
        .font({ ...AppTokens.Typography.title })
        .fontColor(AppTokens.Colors.onSurface)
      
      Row({ space: AppTokens.Spacing.sm }) {
        Button("Calm")
          .font({ ...AppTokens.Typography.label })
          .fontColor(AppTokens.Colors.onPrimary)
          .backgroundColor(AppTokens.Colors.primary)
          .borderRadius(AppTokens.Shapes.medium)
        
        Button("Fire")
          .font({ ...AppTokens.Typography.label })
          .fontColor(AppTokens.Colors.onTertiary)
          .backgroundColor(AppTokens.Colors.tertiary)
          .borderRadius(AppTokens.Shapes.medium)
      }
    }
    .padding(AppTokens.Spacing.lg)
    .width('100%')
    .backgroundColor(AppTokens.Colors.surfaceVariant)
    .borderRadius(AppTokens.Shapes.large)
  }
}

@Component
struct BottomInputBar {
  @Link text: string;

  build() {
    Row({ space: AppTokens.Spacing.sm }) {
      Stack({ alignContent: Alignment.Start }) {
        if (this.text.length === 0) {
          Text("Message dock...")
            .font({ ...AppTokens.Typography.label })
            .fontColor(Color(AppTokens.Colors.onSurface).withOpacity(0.6))
            .margin({ left: AppTokens.Spacing.md })
        }
        TextInput({ placeholder: '' })
          .type(InputType.Normal)
          .text(this.text)
          .onChange((value: string) => {
            this.text = value;
          })
          .font({ ...AppTokens.Typography.body })
          .fontColor(AppTokens.Colors.onSurface)
          .padding({ left: AppTokens.Spacing.md, right: AppTokens.Spacing.md, top: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.sm })
          .height(48)
          .backgroundColor(AppTokens.Colors.surface)
          .borderRadius(AppTokens.Shapes.medium)
      }
      .height(48)
      .flexShrink(1)
      
      Button("Send")
        .font({ ...AppTokens.Typography.label })
        .fontColor(AppTokens.Colors.onPrimary)
        .backgroundColor(AppTokens.Colors.primary)
        .borderRadius(AppTokens.Shapes.medium)
        .height(48)
        .minWidth(80)
    }
    .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.sm })
    .backgroundColor(AppTokens.Colors.surfaceVariant)
    .shadow({ radius: 6, color: '#00000033', offsetY: -2 })
  }
}