import { BusinessError } from '@kit.BasicServicesKit';

// --- Data Models ---

interface Author {
  name: string;
  avatarColor: string; // Using hex strings for ArkTS Color
}

interface Reply {
  id: number;
  author: Author;
  timestamp: string;
  text: string;
  votes: number;
}

interface Post {
  author: Author;
  timestamp: string;
  title: string;
  body: string;
  votes: number;
  commentCount: number;
}

// --- Design Tokens ---

const AppTokens = {
  Colors: {
    primary: '#00E5FF',
    secondary: '#FF00AA',
    tertiary: '#76FF02',
    background: '#101024',
    surface: '#1B1B3A',
    surfaceVariant: '#282850',
    outline: '#444469',
    warning: '#FFD700',
    onPrimary: '#000000',
    onSurface: '#E0E0FF'
  },
  Typography: {
    title: { size: 20, weight: FontWeight.Medium },
    headline: { size: 22, weight: FontWeight.Semibold },
    body: { size: 18, weight: FontWeight.Normal },
    label: { size: 16, weight: FontWeight.Medium },
    small: { size: 14, weight: FontWeight.Medium }
  },
  Shapes: {
    small: 6,
    medium: 12,
    large: 20
  },
  Spacing: {
    xs: 6,
    sm: 10,
    md: 16,
    lg: 20,
    xl: 28
  }
};

// --- Components ---

@Component
struct UpVoteArrow {
  @Prop color: string;

  build() {
    Stack() {
      PathRenderer({
        commands: [
          'M 14 0 L 28 14 L 14 28 L 0 14 Z'
        ],
        fill: this.color
      })
    }
    .width(28)
    .height(28)
  }
}

@Component
struct AuthorInfo {
  @ObjectLink author: Author;
  @Prop timestamp: string;

  build() {
    Row() {
      Stack() {
        Circle()
          .fill(this.author.avatarColor)
          .width(28)
          .height(28)
        
        Circle()
          .fill(Color.Black.opacity(0.2))
          .width(10)
          .height(10)
          .position({ x: 14, y: 14 }) // Centered roughly
      }

      Text(this.author.name)
        .font-size(AppTokens.Typography.small.size)
        .fontWeight(FontWeight.Bold)
        .fontColor(this.author.avatarColor)

      Text(this.timestamp)
        .font-size(AppTokens.Typography.small.size)
        .fontColor(AppTokens.Colors.outline)
    }
    .margin({ right: AppTokens.Spacing.sm })
  }
}

@Component
struct InfoChip {
  @Prop text: string;

  build() {
    Text(this.text)
      .font-size(AppTokens.Typography.small.size)
      .fontWeight(FontWeight.Bold)
      .fontColor(AppTokens.Colors.outline)
  }
}

@Component
struct PostCard {
  @ObjectLink post: Post;
  @Link voteState: number;
  onVote: (newVote: number) => void;

  build() {
    Row() {
      // Vote Column
      Column() {
        Button({ type: ButtonType.Circle }) {
          UpVoteArrow({ color: this.voteState === 1 ? AppTokens.Colors.secondary : AppTokens.Colors.outline })
        }
        .onClick(() => {
          this.onVote(this.voteState === 1 ? 0 : 1);
        })
        .backgroundColor(Color.Transparent)
        .borderWidth(0)

        Text(`${this.post.votes + this.voteState - 1}`)
          .font-size(AppTokens.Typography.title.size)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.voteState !== 0 ? AppTokens.Colors.secondary : AppTokens.Colors.onSurface)

        Button({ type: ButtonType.Circle }) {
          UpVoteArrow({ color: this.voteState === -1 ? AppTokens.Colors.primary : AppTokens.Colors.outline })
            .rotate({ angle: 180 })
        }
        .onClick(() => {
          this.onVote(this.voteState === -1 ? 0 : -1);
        })
        .backgroundColor(Color.Transparent)
        .borderWidth(0)
      }
      .width(60)
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(HorizontalAlign.Center)

      // Content Column
      Column({ space: AppTokens.Spacing.sm }) {
        AuthorInfo({ author: this.post.author, timestamp: this.post.timestamp })

        Text(this.post.title)
          .font-size(AppTokens.Typography.headline.size)
          .fontWeight(AppTokens.Typography.headline.weight)
          .fontColor(AppTokens.Colors.onSurface)
          .textAlign(TextAlign.Start)

        Text(this.post.body)
          .font-size(AppTokens.Typography.body.size)
          .fontWeight(AppTokens.Typography.body.weight)
          .fontColor(new Color(AppTokens.Colors.onSurface).opacity(0.8))
          .textAlign(TextAlign.Start)

        Row() {
          InfoChip({ text: `${this.post.commentCount} Comments` })
          InfoChip({ text: "Share" })
        }
        .justifyContent(FlexAlign.Start)
        .margin({ top: AppTokens.Spacing.sm })
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)
    }
    .padding(AppTokens.Spacing.lg)
    .width('100%')
    .backgroundColor(AppTokens.Colors.surface)
  }
}

@Component
struct ReplyCard {
  @ObjectLink reply: Reply;

  build() {
    Row() {
      Rectangle()
        .fill(new Color(this.reply.author.avatarColor).opacity(0.5))
        .width(3)
        .borderRadius(1.5)

      Column({ space: AppTokens.Spacing.xs }) {
        AuthorInfo({ author: this.reply.author, timestamp: this.reply.timestamp })

        Text(this.reply.text)
          .font-size(AppTokens.Typography.body.size)
          .fontWeight(AppTokens.Typography.body.weight)
          .fontColor(new Color(AppTokens.Colors.onSurface).opacity(0.9))
          .textAlign(TextAlign.Start)

        Row() {
          InfoChip({ text: `${this.reply.votes} votes` })
          InfoChip({ text: "Reply" })
        }
        .justifyContent(FlexAlign.Start)
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)
      .margin({ left: AppTokens.Spacing.md })
    }
    .width('100%')
    .alignItems(VerticalAlign.Top)
  }
}

@Component
struct TopAppBar {
  build() {
    Stack() {
      Rectangle()
        .fill(AppTokens.Colors.surface)
        .height(60)
        .position({ x: 0, y: 0 })
        .width('100%')

      Row() {
        // Back Button Icon
        Button({ type: ButtonType.Circle }) {
          Stack() {
            // Simple SVG-like path for back arrow
            PathRenderer({
              commands: [
                'M 24 12 L 0 12',
                'M 0 12 L 12 0',
                'M 0 12 L 12 24'
              ],
              stroke: new Stroke({ width: 3, color: AppTokens.Colors.primary })
            })
          }
          .width(24)
          .height(24)
        }
        .backgroundColor(Color.Transparent)
        .borderWidth(0)
        .width(50)
        .height(50)

        Flex({ justifyContent: FlexAlign.Center, alignItems: VerticalAlign.Center }) {
          Text("r/jetpackcompose")
            .font-size(AppTokens.Typography.title.size)
            .fontWeight(AppTokens.Typography.title.weight)
            .fontColor(AppTokens.Colors.onSurface)
        }
        .layoutWeight(1)

        // Placeholder for right side
        Blank()
          .width(50)
          .height(50)
      }
      .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
      .width('100%')
      .height(60)
    }
    .width('100%')
    .height(60)
  }
}

@Component
struct BottomCommentBar {
  @Link commentText: string;

  build() {
    Column() {
      Divider()
        .color(new Color(AppTokens.Colors.outline).opacity(0.3))
        .margin({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })

      Row() {
        Stack({ alignContent: Alignment.Start }) {
          if (this.commentText.length === 0) {
            Text("Add a comment...")
              .font-size(AppTokens.Typography.body.size)
              .fontWeight(AppTokens.Typography.body.weight)
              .fontColor(AppTokens.Colors.outline)
              .margin({ left: AppTokens.Spacing.lg })
          }

          TextInput({ placeholder: '' })
            .text(this.commentText)
            .onChange((value: string) => {
              this.commentText = value;
            })
            .font-size(AppTokens.Typography.body.size)
            .fontWeight(AppTokens.Typography.body.weight)
            .fontColor(AppTokens.Colors.onSurface)
            .backgroundColor(Color.Transparent)
            .margin({ left: AppTokens.Spacing.lg })
            .width('100%')
        }
        .layoutWeight(1)
        .backgroundColor(AppTokens.Colors.surfaceVariant)
        .borderRadius(AppTokens.Shapes.large)
        .height(52)

        Button("POST") {
          // Post action
        }
        .font-size(AppTokens.Typography.label.size)
        .fontWeight(AppTokens.Typography.label.weight)
        .fontColor(AppTokens.Colors.onPrimary)
        .backgroundColor(AppTokens.Colors.primary)
        .borderRadius(AppTokens.Shapes.large)
        .height(52)
        .margin({ left: AppTokens.Spacing.md })
      }
      .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.md })
      .backgroundColor(AppTokens.Colors.surface)
    }
    .width('100%')
    .backgroundColor(AppTokens.Colors.surface)
  }
}

@Entry
@Component
struct ForumPostView {
  @State voteState: number = 1;
  @State commentText: string = "";

  private post: Post = {
    author: { name: "user/compose_master", avatarColor: AppTokens.Colors.tertiary },
    timestamp: "8 hours ago",
    title: "The power of Jetpack Compose for single-file UIs",
    body: "Creating fully functional, beautiful UIs in a single Kotlin file is not just possible, it's becoming a new standard for prototypes and minimalist apps. What are your thoughts on this approach?",
    votes: 1337,
    commentCount: 42
  };

  private replies: Reply[] = [
    { id: 1, author: { name: "dev/android_fan", avatarColor: AppTokens.Colors.secondary }, timestamp: "7h ago", text: "Absolutely agree! It simplifies dependency management and makes sharing snippets a breeze.", votes: 25 },
    { id: 2, author: { name: "ux/designer_jane", avatarColor: AppTokens.Colors.primary }, timestamp: "5h ago", text: "From a design perspective, having the design tokens and theme right next to the UI components is a game-changer for consistency.", votes: 18 }
  ];

  build() {
    Column() {
      TopAppBar()

      Scroll() {
        Column() {
          PostCard({ 
            post: this.post, 
            voteState: $voteState, 
            onVote: (newVote: number) => {
              this.voteState = newVote;
            } 
          })

          Text("TOP COMMENTS")
            .font-size(AppTokens.Typography.small.size)
            .fontWeight(AppTokens.Typography.small.weight)
            .fontColor(AppTokens.Colors.outline)
            .textAlign(TextAlign.Start)
            .width('100%')
            .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.sm })

          ForEach(this.replies, (reply: Reply) => {
            ReplyCard({ reply: reply })
              .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.sm })
          })
        }
      }
      .layoutWeight(1)
      .backgroundColor(AppTokens.Colors.background)

      BottomCommentBar({ commentText: $commentText })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
    .statusBarMode(StatusBarMode.Custom)
    .systemBarProperties({ statusBarColor: AppTokens.Colors.background })
  }
}