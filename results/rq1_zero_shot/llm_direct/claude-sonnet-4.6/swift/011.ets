import { router } from '@kit.ArkUI';

// Data Models
interface Author {
  name: string;
  avatarColor: string;
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

// Design Tokens
class AppTokens {
  static Colors = {
    primary: '#00E5FF',
    secondary: '#FF00AA',
    tertiary: '#76FF03',
    background: '#101024',
    surface: '#1C1C3A',
    surfaceVariant: '#282850',
    outline: '#444469',
    warning: '#FFD600',
    onPrimary: '#000000',
    onSurface: '#E0E0FF',
  };

  static Typography = {
    titleSize: 20,
    headlineSize: 22,
    bodySize: 18,
    labelSize: 16,
    smallSize: 14,
  };

  static Shapes = {
    small: 6,
    medium: 12,
    large: 20,
  };

  static Spacing = {
    xs: 6,
    sm: 10,
    md: 16,
    lg: 20,
    xl: 28,
  };
}

// UpVoteArrow Component
@Component
struct UpVoteArrow {
  color: string = AppTokens.Colors.outline;
  rotated: boolean = false;

  build() {
    Canvas(new CanvasRenderingContext2D(new RenderingContextSettings(true)))
      .width(28)
      .height(28)
      .onReady((context: CanvasRenderingContext2D) => {
        context.clearRect(0, 0, 28, 28);
        context.fillStyle = this.color;
        context.beginPath();
        if (this.rotated) {
          context.moveTo(14, 28);
          context.lineTo(28, 14);
          context.lineTo(14, 0);
          context.lineTo(0, 14);
        } else {
          context.moveTo(14, 0);
          context.lineTo(28, 14);
          context.lineTo(14, 28);
          context.lineTo(0, 14);
        }
        context.closePath();
        context.fill();
      })
  }
}

// AuthorInfo Component
@Component
struct AuthorInfo {
  author: Author = { name: '', avatarColor: '#FFFFFF' };
  timestamp: string = '';

  build() {
    Row({ space: AppTokens.Spacing.sm }) {
      Stack() {
        Circle()
          .width(28)
          .height(28)
          .fill(this.author.avatarColor)
        Circle()
          .width(10)
          .height(10)
          .fill('#33000000')
      }

      Text(this.author.name)
        .fontSize(AppTokens.Typography.smallSize)
        .fontWeight(FontWeight.Bold)
        .fontColor(this.author.avatarColor)

      Text(this.timestamp)
        .fontSize(AppTokens.Typography.smallSize)
        .fontColor(AppTokens.Colors.outline)
    }
  }
}

// InfoChip Component
@Component
struct InfoChip {
  text: string = '';

  build() {
    Text(this.text)
      .fontSize(AppTokens.Typography.smallSize)
      .fontWeight(FontWeight.Bold)
      .fontColor(AppTokens.Colors.outline)
  }
}

// PostCard Component
@Component
struct PostCard {
  post: Post = {
    author: { name: '', avatarColor: '' },
    timestamp: '',
    title: '',
    body: '',
    votes: 0,
    commentCount: 0
  };
  voteState: number = 0;
  onVote: (vote: number) => void = () => {};

  build() {
    Row({ space: AppTokens.Spacing.md }) {
      Column({ space: AppTokens.Spacing.sm }) {
        UpVoteArrow({
          color: this.voteState === 1 ? AppTokens.Colors.secondary : AppTokens.Colors.outline,
          rotated: false
        })
          .onClick(() => {
            this.onVote(this.voteState === 1 ? 0 : 1);
          })

        Text(`${this.post.votes + this.voteState - 1}`)
          .fontSize(AppTokens.Typography.titleSize)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.voteState !== 0 ? AppTokens.Colors.secondary : AppTokens.Colors.onSurface)

        UpVoteArrow({
          color: this.voteState === -1 ? AppTokens.Colors.primary : AppTokens.Colors.outline,
          rotated: true
        })
          .onClick(() => {
            this.onVote(this.voteState === -1 ? 0 : -1);
          })
      }
      .width(60)
      .alignItems(HorizontalAlign.Center)

      Column({ space: AppTokens.Spacing.sm }) {
        AuthorInfo({ author: this.post.author, timestamp: this.post.timestamp })

        Text(this.post.title)
          .fontSize(AppTokens.Typography.headlineSize)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onSurface)
          .width('100%')

        Text(this.post.body)
          .fontSize(AppTokens.Typography.bodySize)
          .fontColor(AppTokens.Colors.onSurface + 'CC')
          .width('100%')

        Row({ space: AppTokens.Spacing.xl }) {
          InfoChip({ text: `${this.post.commentCount} Comments` })
          InfoChip({ text: 'Share' })
        }
        .margin({ top: AppTokens.Spacing.sm })
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)
    }
    .padding(AppTokens.Spacing.lg)
    .width('100%')
    .alignItems(VerticalAlign.Top)
    .backgroundColor(AppTokens.Colors.surface)
  }
}

// ReplyCard Component
@Component
struct ReplyCard {
  reply: Reply = {
    id: 0,
    author: { name: '', avatarColor: '' },
    timestamp: '',
    text: '',
    votes: 0
  };

  build() {
    Row({ space: AppTokens.Spacing.md }) {
      Column()
        .width(3)
        .height('100%')
        .backgroundColor(this.reply.author.avatarColor + '80')
        .borderRadius(1.5)

      Column({ space: AppTokens.Spacing.xs }) {
        AuthorInfo({ author: this.reply.author, timestamp: this.reply.timestamp })

        Text(this.reply.text)
          .fontSize(AppTokens.Typography.bodySize)
          .fontColor(AppTokens.Colors.onSurface + 'E6')
          .width('100%')

        Row({ space: AppTokens.Spacing.md }) {
          InfoChip({ text: `${this.reply.votes} votes` })
          InfoChip({ text: 'Reply' })
        }
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .alignItems(VerticalAlign.Top)
  }
}

// TopAppBar Component
@Component
struct TopAppBar {
  build() {
    Stack() {
      Rectangle()
        .width('100%')
        .height(60)
        .fill(AppTokens.Colors.surface)

      Row() {
        Stack() {
          Canvas(new CanvasRenderingContext2D(new RenderingContextSettings(true)))
            .width(24)
            .height(24)
            .onReady((context: CanvasRenderingContext2D) => {
              context.strokeStyle = AppTokens.Colors.primary;
              context.lineWidth = 3;
              context.lineCap = 'round';

              // Horizontal line
              context.beginPath();
              context.moveTo(0, 12);
              context.lineTo(24, 12);
              context.stroke();

              // Top arrow line
              context.beginPath();
              context.moveTo(0, 12);
              context.lineTo(12, 0);
              context.stroke();

              // Bottom arrow line
              context.beginPath();
              context.moveTo(0, 12);
              context.lineTo(12, 24);
              context.stroke();
            })
        }
        .width(50)
        .height(50)

        Blank()

        Text('r/jetpackcompose')
          .fontSize(AppTokens.Typography.titleSize)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onSurface)

        Blank()

        Row()
          .width(50)
          .height(50)
      }
      .width('100%')
      .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
    }
    .width('100%')
    .height(60)
  }
}

// BottomCommentBar Component
@Component
struct BottomCommentBar {
  @Link commentText: string;

  build() {
    Column({ space: 0 }) {
      Divider()
        .color(AppTokens.Colors.outline + '4D')
        .strokeWidth(1)
        .margin({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })

      Row({ space: AppTokens.Spacing.md }) {
        Stack({ alignContent: Alignment.Start }) {
          RoundedRect(0, 0, 0, 0, AppTokens.Shapes.large)

          Row() {
            if (this.commentText.length === 0) {
              Text('Add a comment...')
                .fontSize(AppTokens.Typography.bodySize)
                .fontColor(AppTokens.Colors.outline)
                .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
            }

            TextInput({ placeholder: '', text: this.commentText })
              .fontSize(AppTokens.Typography.bodySize)
              .fontColor(AppTokens.Colors.onSurface)
              .backgroundColor(Color.Transparent)
              .layoutWeight(1)
              .onChange((value: string) => {
                this.commentText = value;
              })
              .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
          }
          .width('100%')
          .height(52)
          .backgroundColor(AppTokens.Colors.surfaceVariant)
          .borderRadius(AppTokens.Shapes.large)
        }
        .layoutWeight(1)
        .height(52)

        Button('POST')
          .fontSize(AppTokens.Typography.labelSize)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppTokens.Colors.onPrimary)
          .backgroundColor(AppTokens.Colors.primary)
          .borderRadius(AppTokens.Shapes.large)
          .height(52)
          .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
      }
      .padding({
        left: AppTokens.Spacing.lg,
        right: AppTokens.Spacing.lg,
        top: AppTokens.Spacing.md,
        bottom: AppTokens.Spacing.md
      })
      .backgroundColor(AppTokens.Colors.surface)
      .width('100%')
    }
    .width('100%')
  }
}

// Main ForumPostView
@Entry
@Component
struct ForumPostView {
  @State voteState: number = 1;
  @State commentText: string = '';

  private post: Post = {
    author: { name: 'user/compose_master', avatarColor: AppTokens.Colors.tertiary },
    timestamp: '8 hours ago',
    title: 'The power of Jetpack Compose for single-file UIs',
    body: 'Creating fully functional, beautiful UIs in a single Kotlin file is not just possible, it\'s becoming a new standard for prototypes and minimalist apps. What are your thoughts on this approach?',
    votes: 1337,
    commentCount: 42
  };

  private replies: Reply[] = [
    {
      id: 1,
      author: { name: 'dev/android_fan', avatarColor: AppTokens.Colors.secondary },
      timestamp: '7h ago',
      text: 'Absolutely agree! It simplifies dependency management and makes sharing snippets a breeze.',
      votes: 25
    },
    {
      id: 2,
      author: { name: 'ux/designer_jane', avatarColor: AppTokens.Colors.primary },
      timestamp: '5h ago',
      text: 'From a design perspective, having the design tokens and theme right next to the UI components is a game-changer for consistency.',
      votes: 18
    }
  ];

  build() {
    Column({ space: 0 }) {
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

          Text('TOP COMMENTS')
            .fontSize(AppTokens.Typography.smallSize)
            .fontColor(AppTokens.Colors.outline)
            .width('100%')
            .textAlign(TextAlign.Start)
            .padding({
              left: AppTokens.Spacing.lg,
              right: AppTokens.Spacing.lg,
              top: AppTokens.Spacing.sm,
              bottom: AppTokens.Spacing.sm
            })

          ForEach(this.replies, (reply: Reply) => {
            ReplyCard({ reply: reply })
              .padding({
                left: AppTokens.Spacing.lg,
                right: AppTokens.Spacing.lg,
                top: AppTokens.Spacing.sm,
                bottom: AppTokens.Spacing.sm
              })
          }, (reply: Reply) => reply.id.toString())
        }
        .width('100%')
      }
      .layoutWeight(1)
      .backgroundColor(AppTokens.Colors.background)
      .scrollBar(BarState.Off)

      BottomCommentBar({ commentText: $commentText })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}