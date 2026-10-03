// Index.ets

interface AppTokensColors {
  primary: string;
  secondary: string;
  tertiary: string;
  background: string;
  surface: string;
  surfaceVariant: string;
  outline: string;
  warning: string;
  onPrimary: string;
  onSurface: string;
}

interface AppTokensTypographyItem {
  size: Length;
  weight: FontWeight;
}

interface AppTokensTypography {
  title: AppTokensTypographyItem;
  headline: AppTokensTypographyItem;
  body: AppTokensTypographyItem;
  label: AppTokensTypographyItem;
  small: AppTokensTypographyItem;
}

interface AppTokensShapes {
  small: Length;
  medium: Length;
  large: Length;
}

interface AppTokensSpacing {
  xs: Length;
  sm: Length;
  md: Length;
  lg: Length;
  xl: Length;
}

class AppTokens {
  static readonly Colors: AppTokensColors = {
    primary: '#00E5FF',
    secondary: '#FF00AA',
    tertiary: '#76FF03',
    background: '#101024',
    surface: '#1C1C3A',
    surfaceVariant: '#282850',
    outline: '#44446A',
    warning: '#FFD600',
    onPrimary: '#000000',
    onSurface: '#E0E0FF'
  };

  static readonly Typography: AppTokensTypography = {
    title: { size: 20, weight: FontWeight.Medium },
    headline: { size: 22, weight: FontWeight.Bold },
    body: { size: 18, weight: FontWeight.Normal },
    label: { size: 16, weight: FontWeight.Medium },
    small: { size: 14, weight: FontWeight.Medium }
  };

  static readonly Shapes: AppTokensShapes = {
    small: 6,
    medium: 12,
    large: 20
  };

  static readonly Spacing: AppTokensSpacing = {
    xs: 6,
    sm: 10,
    md: 16,
    lg: 20,
    xl: 28
  };
}

interface Author {
  name: string;
  avatarColor: ResourceColor;
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

@Component
export struct UpVoteArrow {
  color: ResourceColor = Color.Black;

  build() {
    Stack() {
      Polygon({ width: 28, height: 28 })
        .points([[14, 0], [28, 14], [14, 28], [0, 14]])
        .fill(this.color)
    }
    .width(28)
    .height(28)
  }
}

@Component
export struct AuthorInfo {
  author: Author = { name: "", avatarColor: Color.Black };
  timestamp: string = "";

  build() {
    Row({ space: AppTokens.Spacing.sm }) {
      Stack() {
        Circle({ width: 28, height: 28 })
          .fill(this.author.avatarColor)
        Circle({ width: 10, height: 10 })
          .fill('#33000000')
      }
      .width(28)
      .height(28)

      Text(this.author.name)
        .fontSize(AppTokens.Typography.small.size)
        .fontWeight(AppTokens.Typography.small.weight)
        .fontColor(this.author.avatarColor)

      Text(this.timestamp)
        .fontSize(AppTokens.Typography.small.size)
        .fontWeight(AppTokens.Typography.small.weight)
        .fontColor(AppTokens.Colors.outline)
    }
    .alignItems(VerticalAlign.Center)
  }
}

@Component
export struct InfoChip {
  text: string = "";

  build() {
    Text(this.text)
      .fontSize(AppTokens.Typography.small.size)
      .fontWeight(AppTokens.Typography.small.weight)
      .fontColor(AppTokens.Colors.outline)
  }
}

@Component
export struct PostCard {
  post: Post = { author: { name: "", avatarColor: Color.Black }, timestamp: "", title: "", body: "", votes: 0, commentCount: 0 };
  voteState: number = 0;
  onVote: (newVote: number) => void = () => {};

  build() {
    Row({ space: AppTokens.Spacing.md }) {
      Column({ space: AppTokens.Spacing.sm }) {
        Button() {
          UpVoteArrow({ color: this.voteState === 1 ? AppTokens.Colors.secondary : AppTokens.Colors.outline })
        }
        .onClick(() => {
          this.onVote(this.voteState === 1 ? 0 : 1);
        })
        .backgroundColor(Color.Transparent)
        .padding(0)

        Text(`${this.post.votes + this.voteState - 1}`)
          .fontSize(AppTokens.Typography.title.size)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.voteState !== 0 ? AppTokens.Colors.secondary : AppTokens.Colors.onSurface)

        Button() {
          Stack() {
            UpVoteArrow({ color: this.voteState === -1 ? AppTokens.Colors.primary : AppTokens.Colors.outline })
          }
          .rotate({ angle: 180 })
        }
        .onClick(() => {
          this.onVote(this.voteState === -1 ? 0 : -1);
        })
        .backgroundColor(Color.Transparent)
        .padding(0)
      }
      .width(60)
      .alignItems(HorizontalAlign.Center)

      Column({ space: AppTokens.Spacing.sm }) {
        AuthorInfo({ author: this.post.author, timestamp: this.post.timestamp })

        Text(this.post.title)
          .fontSize(AppTokens.Typography.headline.size)
          .fontWeight(AppTokens.Typography.headline.weight)
          .fontColor(AppTokens.Colors.onSurface)
          .width('100%')

        Text(this.post.body)
          .fontSize(AppTokens.Typography.body.size)
          .fontWeight(AppTokens.Typography.body.weight)
          .fontColor(AppTokens.Colors.onSurface)
          .opacity(0.8)
          .width('100%')

        Row({ space: AppTokens.Spacing.xl }) {
          InfoChip({ text: `${this.post.commentCount} Comments` })
          InfoChip({ text: "Share" })
        }
        .margin({ top: AppTokens.Spacing.sm })
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)
    }
    .padding(AppTokens.Spacing.lg)
    .width('100%')
    .backgroundColor(AppTokens.Colors.surface)
    .alignItems(VerticalAlign.Top)
  }
}

@Component
export struct ReplyCard {
  reply: Reply = { id: 0, author: { name: "", avatarColor: Color.Black }, timestamp: "", text: "", votes: 0 };

  build() {
    Row({ space: AppTokens.Spacing.md }) {
      Column() {
        Divider()
          .color(this.reply.author.avatarColor)
          .opacity(0.5)
          .vertical(true)
          .width(3)
          .height('100%')
      }

      Column({ space: AppTokens.Spacing.xs }) {
        AuthorInfo({ author: this.reply.author, timestamp: this.reply.timestamp })

        Text(this.reply.text)
          .fontSize(AppTokens.Typography.body.size)
          .fontWeight(AppTokens.Typography.body.weight)
          .fontColor(AppTokens.Colors.onSurface)
          .opacity(0.9)
          .width('100%')

        Row({ space: AppTokens.Spacing.md }) {
          InfoChip({ text: `${this.reply.votes} votes` })
          InfoChip({ text: "Reply" })
        }
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .alignItems(VerticalAlign.Top)
  }
}

@Component
export struct TopAppBar {
  build() {
    Stack() {
      Column() {
        Column()
          .width('100%')
          .height(60)
          .backgroundColor(AppTokens.Colors.surface)
      }
      .width('100%')
      .height('100%')

      Row() {
        Button() {
          Stack() {
            Column() {
              Path()
                .commands("M0 12 L24 12 M0 12 L12 0 M0 12 L12 24")
                .stroke(AppTokens.Colors.primary)
                .strokeWidth(3)
                .width(24)
                .height(24)
            }
            .width(24)
            .height(24)
          }
          .width(50)
          .height(50)
        }
        .backgroundColor(Color.Transparent)
        .padding(0)

        Blank()

        Text("r/jetpackcompose")
          .fontSize(AppTokens.Typography.title.size)
          .fontWeight(AppTokens.Typography.title.weight)
          .fontColor(AppTokens.Colors.onSurface)

        Blank()

        Column()
          .width(50)
          .height(50)
      }
      .width('100%')
      .height(60)
      .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .height(60)
  }
}

@Component
export struct BottomCommentBar {
  @Link commentText: string;

  build() {
    Column() {
      Divider()
        .color(AppTokens.Colors.outline)
        .opacity(0.3)
        .margin({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })

      Row({ space: AppTokens.Spacing.md }) {
        Stack({ alignContent: Alignment.Start }) {
          Column()
            .width('100%')
            .height(52)
            .backgroundColor(AppTokens.Colors.surfaceVariant)
            .borderRadius(AppTokens.Shapes.large)

          if (this.commentText === "") {
            Text("Add a comment...")
              .fontSize(AppTokens.Typography.body.size)
              .fontWeight(AppTokens.Typography.body.weight)
              .fontColor(AppTokens.Colors.outline)
              .margin({ left: AppTokens.Spacing.lg })
          }

          TextInput({ text: this.commentText, placeholder: "" })
            .onChange((value: string) => {
              this.commentText = value;
            })
            .fontSize(AppTokens.Typography.body.size)
            .fontWeight(AppTokens.Typography.body.weight)
            .fontColor(AppTokens.Colors.onSurface)
            .backgroundColor(Color.Transparent)
            .height(52)
            .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
        }
        .layoutWeight(1)

        Button("POST")
          .fontSize(AppTokens.Typography.label.size)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppTokens.Colors.onPrimary)
          .height(52)
          .backgroundColor(AppTokens.Colors.primary)
          .borderRadius(AppTokens.Shapes.large)
          .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
      }
      .width('100%')
      .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.md })
      .backgroundColor(AppTokens.Colors.surface)
    }
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
        Column({ space: 0 }) {
          PostCard({
            post: this.post,
            voteState: this.voteState,
            onVote: (newVote: number) => {
              this.voteState = newVote;
            }
          })

          Text("TOP COMMENTS")
            .fontSize(AppTokens.Typography.small.size)
            .fontWeight(AppTokens.Typography.small.weight)
            .fontColor(AppTokens.Colors.outline)
            .width('100%')
            .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.sm })

          ForEach(this.replies, (reply: Reply) => {
            ReplyCard({ reply: reply })
              .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.sm })
          }, (reply: Reply) => reply.id.toString())
        }
      }
      .layoutWeight(1)
      .backgroundColor(AppTokens.Colors.background)
      .align(Alignment.Top)

      BottomCommentBar({ commentText: $commentText })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}