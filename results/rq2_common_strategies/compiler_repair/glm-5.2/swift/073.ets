// MARK: - App Tokens & Colors
class AppTokens {
  static Colors: Record<string, string> = {
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
  }
  
  static Typography: Record<string, number> = {
    display: 28,
    headline: 22,
    title: 16,
    body: 14,
    label: 12
  }
  
  static Spacing: Record<string, number> = {
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
    xxl: 32,
    xxxl: 44
  }
  
  static Shapes: Record<string, number> = {
    small: 12,
    medium: 16,
    large: 20
  }
}

// MARK: - Models
class ChatThread {
  id: string;
  name: string;
  status: string;
  unread: number;
  snippet: string;
  isPriority: boolean;

  constructor(name: string, status: string, unread: number, snippet: string, isPriority: boolean) {
    this.id = Math.random().toString(36).substring(2, 9);
    this.name = name;
    this.status = status;
    this.unread = unread;
    this.snippet = snippet;
    this.isPriority = isPriority;
  }
}

// MARK: - Main Screen
@Entry
@Component
struct HoloChatDockScreen {
  @State activeFilter: string = "Live";
  @State draftMessage: string = "";
  
  private filters: string[] = ["Live", "Pinned", "Escalated", "Silent"];
  private threads: ChatThread[] = [
    new ChatThread("Orbital Finance", "Rolling sync", 5, "Need rates for Q4", true),
    new ChatThread("Beacon Ops", "Docked", 0, "Switching to holo feed", false),
    new ChatThread("Nova Crew", "Hotline", 2, "Uploading scan pack now", true)
  ];

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      // Background
      Column() {
        // Top Bar
        CustomTopBar()
        
        // Content
        Scroll() {
          Column({ space: AppTokens.Spacing.md }) {
            // Filters
            Scroll() {
              Row({ space: AppTokens.Spacing.sm }) {
                ForEach(this.filters, (filter: string) => {
                  AssistChip({
                    label: filter,
                    isSelected: this.activeFilter === filter,
                    action: () => { this.activeFilter = filter; }
                  })
                })
              }
              .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
            }
            .scrollable(ScrollDirection.Horizontal)
            .scrollBar(BarState.Off)
            
            // Status Summary
            StatusSummary()
              .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
            
            // Threads List
            ForEach(this.threads, (thread: ChatThread) => {
              ChatThreadCard({ thread: thread })
                .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
            })
            
            // Action Footer
            ActionFooter()
              .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
            
            // Spacer for bottom bar + FAB area
            Blank().height(100)
          }
          .padding({ top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.md })
        }
        .scrollBar(BarState.Off)
        .layoutWeight(1)
      }
      .width('100%')
      .height('100%')
      .backgroundColor(AppTokens.Colors.background)
      
      // FAB (Floating Action Button) overlay
      Row() {
        Blank()
        Button("New")
          .onClick(() => {
            // Action
          })
          .fontSize(AppTokens.Typography.label)
          .fontColor(AppTokens.Colors.onPrimary)
          .padding({ left: 16, right: 16, top: 16, bottom: 16 })
          .backgroundColor(AppTokens.Colors.primary)
          .borderRadius(AppTokens.Shapes.medium)
          .shadow({ radius: 4 })
          .margin({ right: AppTokens.Spacing.lg, bottom: 80 })
      }
      .width('100%')
      .height('100%')
      
      // Bottom Bar
      BottomInputBar({ text: this.draftMessage })
    }
    .width('100%')
    .height('100%')
  }
}

// MARK: - Components

@Component
struct CustomTopBar {
  build() {
    Row() {
      Button("Hub")
        .onClick(() => {
          // Action
        })
        .fontSize(AppTokens.Typography.label)
        .fontColor(AppTokens.Colors.onSurface)
        .backgroundColor(Color.Transparent)
      
      Blank()
      
      Column() {
        Text("HoloChat Dock")
          .fontSize(AppTokens.Typography.title)
          .fontColor(AppTokens.Colors.onSurface)
        Text("Dark neon bridge")
          .fontSize(AppTokens.Typography.label)
          .fontColor(AppTokens.Colors.onSurface)
          .opacity(0.7)
      }
      .alignItems(HorizontalAlign.Start)
      
      Blank()
      
      Button("Status")
        .onClick(() => {
          // Action
        })
        .fontSize(AppTokens.Typography.label)
        .fontColor(AppTokens.Colors.secondary)
        .backgroundColor(Color.Transparent)
    }
    .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.sm })
    .backgroundColor(AppTokens.Colors.surface)
    .width('100%')
  }
}

@Component
struct AssistChip {
  @Prop label: string;
  @Prop isSelected: boolean;
  action: () => void = () => {};

  build() {
    Button(this.label)
      .onClick(() => {
        if (this.action) {
          this.action();
        }
      })
      .fontSize(AppTokens.Typography.label)
      .fontColor(this.isSelected ? AppTokens.Colors.onSecondary : AppTokens.Colors.onSurface)
      .padding({ left: 16, right: 16, top: 8, bottom: 8 })
      .backgroundColor(this.isSelected ? AppTokens.Colors.secondary : AppTokens.Colors.surfaceVariant)
      .borderRadius(AppTokens.Shapes.small)
      .border({ width: this.isSelected ? 0 : 1, color: AppTokens.Colors.outline })
  }
}

@Component
struct StatusSummary {
  build() {
    Row({ space: AppTokens.Spacing.sm }) {
      SummaryBlock({ title: "Live docks", value: "12", accent: AppTokens.Colors.secondary })
      SummaryBlock({ title: "Escalations", value: "3", accent: AppTokens.Colors.tertiary })
      SummaryBlock({ title: "Queued", value: "5", accent: AppTokens.Colors.primary })
    }
    .width('100%')
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
        .margin({ bottom: AppTokens.Spacing.xs })
      
      Text(this.title.toUpperCase())
        .fontSize(AppTokens.Typography.label)
        .fontColor(AppTokens.Colors.onSurface)
        .opacity(0.7)
        .margin({ bottom: AppTokens.Spacing.xs })
      
      Text(this.value)
        .fontSize(AppTokens.Typography.display)
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
struct ChatThreadCard {
  @Prop thread: ChatThread;

  build() {
    Column({ space: AppTokens.Spacing.sm }) {
      Row() {
        Column({ space: AppTokens.Spacing.xs }) {
          Text(this.thread.name)
            .fontSize(AppTokens.Typography.headline)
            .fontColor(AppTokens.Colors.onSurface)
          
          Text(this.thread.status)
            .fontSize(AppTokens.Typography.label)
            .fontColor(this.thread.isPriority ? AppTokens.Colors.secondary : AppTokens.Colors.onSurface)
            .opacity(this.thread.isPriority ? 1 : 0.7)
        }
        .alignItems(HorizontalAlign.Start)
        .layoutWeight(1)
        
        Text(this.thread.unread > 0 ? `+${this.thread.unread}` : "✓")
          .fontSize(AppTokens.Typography.label)
          .fontColor(AppTokens.Colors.onSurface)
          .padding({ left: AppTokens.Spacing.sm, right: AppTokens.Spacing.sm, top: AppTokens.Spacing.xs, bottom: AppTokens.Spacing.xs })
          .backgroundColor(AppTokens.Colors.surfaceVariant)
          .borderRadius(AppTokens.Shapes.small)
      }
      .width('100%')
      
      Text(this.thread.snippet)
        .fontSize(AppTokens.Typography.body)
        .fontColor(AppTokens.Colors.onSurface)
        .opacity(0.9)
      
      Row({ space: AppTokens.Spacing.sm }) {
        Text(this.thread.isPriority ? "Priority" : "Standard")
          .fontSize(AppTokens.Typography.label)
          .fontColor(AppTokens.Colors.onSurface)
          .padding({ left: AppTokens.Spacing.sm, right: AppTokens.Spacing.sm, top: AppTokens.Spacing.xs, bottom: AppTokens.Spacing.xs })
          .backgroundColor(AppTokens.Colors.surfaceVariant)
          .borderRadius(AppTokens.Shapes.small)
        
        Button("Open")
          .onClick(() => {
            // Action
          })
          .fontSize(AppTokens.Typography.label)
          .fontColor(AppTokens.Colors.secondary)
          .backgroundColor(Color.Transparent)
      }
    }
    .alignItems(HorizontalAlign.Start)
    .padding(AppTokens.Spacing.md)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.large)
    .border({ width: 1, color: AppTokens.Colors.outline })
  }
}

@Component
struct ActionFooter {
  build() {
    Column({ space: AppTokens.Spacing.sm }) {
      Text("Dock filters")
        .fontSize(AppTokens.Typography.title)
        .fontColor(AppTokens.Colors.onSurface)
      
      Row({ space: AppTokens.Spacing.sm }) {
        Button("Calm")
          .onClick(() => {
            // Action
          })
          .fontSize(AppTokens.Typography.label)
          .fontColor(AppTokens.Colors.onPrimary)
          .padding({ left: 16, right: 16, top: 10, bottom: 10 })
          .backgroundColor(AppTokens.Colors.primary)
          .borderRadius(AppTokens.Shapes.medium)
        
        Button("Fire")
          .onClick(() => {
            // Action
          })
          .fontSize(AppTokens.Typography.label)
          .fontColor(AppTokens.Colors.onTertiary)
          .padding({ left: 16, right: 16, top: 10, bottom: 10 })
          .backgroundColor(AppTokens.Colors.tertiary)
          .borderRadius(AppTokens.Shapes.medium)
      }
    }
    .alignItems(HorizontalAlign.Start)
    .padding(AppTokens.Spacing.lg)
    .backgroundColor(AppTokens.Colors.surfaceVariant)
    .borderRadius(AppTokens.Shapes.large)
    .width('100%')
  }
}

@Component
struct BottomInputBar {
  @Link text: string;

  build() {
    Row({ space: AppTokens.Spacing.sm }) {
      Stack({ alignContent: Alignment.Start }) {
        if (this.text === "") {
          Text("Message dock...")
            .fontSize(AppTokens.Typography.label)
            .fontColor(AppTokens.Colors.onSurface)
            .opacity(0.6)
            .padding({ left: AppTokens.Spacing.md, right: AppTokens.Spacing.md })
        }
        TextInput({ text: this.text })
          .fontSize(AppTokens.Typography.body)
          .fontColor(AppTokens.Colors.onSurface)
          .padding({ left: AppTokens.Spacing.md, right: AppTokens.Spacing.md, top: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.sm })
          .backgroundColor(Color.Transparent)
          .onChange((value: string) => {
            this.text = value;
          })
      }
      .height(48)
      .backgroundColor(AppTokens.Colors.surface)
      .borderRadius(AppTokens.Shapes.medium)
      .layoutWeight(1)
      
      Button("Send")
        .onClick(() => {
          // Action
        })
        .fontSize(AppTokens.Typography.label)
        .fontColor(AppTokens.Colors.onPrimary)
        .padding({ left: 20, right: 20 })
        .height(48)
        .backgroundColor(AppTokens.Colors.primary)
        .borderRadius(AppTokens.Shapes.medium)
    }
    .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.sm })
    .backgroundColor(AppTokens.Colors.surfaceVariant)
    .shadow({ radius: 6, color: 'rgba(0,0,0,0.2)', offsetY: -2 })
    .width('100%')
  }
}