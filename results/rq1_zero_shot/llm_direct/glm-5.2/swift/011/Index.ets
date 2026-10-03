// AppTokens: Design system tokens
class AppTokens {
  static readonly Colors = {
    primary: '#00E5FF',
    secondary: '#FF00AA',
    tertiary: '#76FF03',
    background: '#101024',
    surface: '#1C1C3A',
    surfaceVariant: '#282850',
    outline: '#444444',
    warning: '#FFD600',
    onPrimary: '#000000',
    onSurface: '#E0E0FF'
  };

  static readonly Typography = {
    title: { size: 20, weight: FontWeight.Medium },
    headline: { size: 22, weight: FontWeight.Bold },
    body: { size: 18, weight: FontWeight.Normal },
    label: { size: 16, weight: FontWeight.Medium },
    small: { size: 14, weight: FontWeight.Medium }
  };

  static readonly Shapes = {
    small: 6,
    medium: 12,
    large: 20
  };

  static readonly Spacing = {
    xs: 6,
    sm: 10,
    md: 16,
    lg: 20,
    xl: 28
  };
}

// Data Models
class Author {
  name: string;
  avatarColor: ResourceColor;

  constructor(name: string, avatarColor: ResourceColor) {
    this.name = name;
    this.avatarColor = avatarColor;
  }
}

class Reply {
  id: number;
  author: Author;
  timestamp: string;
  text: string;
  votes: number;

  constructor(id: number, author: Author, timestamp: string, text: string, votes: number) {
    this.id = id;
    this.author = author;
    this.timestamp = timestamp;
    this.text = text;
    this.votes = votes;
  }
}

class Post {
  author: Author;
  timestamp: string;
  title: string;
  body: string;
  votes: number;
  commentCount: number;

  constructor(author: Author, timestamp: string, title: string, body: string, votes: number, commentCount: number) {
    this.author = author;
    this.timestamp = timestamp;
    this.title = title;
    this.body = body;
    this.votes = votes;
    this.commentCount = commentCount;
  }
}

// Global State
@Entry
@Component
struct ForumPostApp {
  @State voteState: number = 1;
  @State commentText: string = '';

  private post: Post = new Post(
    new Author('user/compose_master', AppTokens.Colors.tertiary),
    '8 hours ago',
    'The power of Jetpack Compose for single-file UIs',
    'Creating fully functional, beautiful UIs in a single Kotlin file is not just possible, it\'s becoming a new standard for prototypes and minimalist apps. What are your thoughts on this approach?',
    1337,
    42
  );

  private replies: Reply[] = [
    new Reply(1, new Author('dev/android_fan', AppTokens.Colors.secondary), '7h ago', 'Absolutely agree! It simplifies dependency management and makes sharing snippets a breeze.', 25),
    new Reply(2, new Author('ux/designer_jane', AppTokens.Colors.primary), '5h ago', 'From a design perspective, having the design tokens and theme right next to the UI components is a game-changer for consistency.', 18)
  ];

  build() {
    Column() {
      TopAppBar()

      Scroll() {
        Column() {
          PostCard({ post: this.post, voteState: this.voteState, onVote: (newVote: number) => {
            this.voteState = newVote;
          }})

          Text('TOP COMMENTS')
            .fontSize(AppTokens.Typography.small.size)
            .fontWeight(AppTokens.Typography.small.weight)
            .fontColor(AppTokens.Colors.outline)
            .width('100%')
            .padding({ horizontal: AppTokens.Spacing.lg, vertical: AppTokens.Spacing.sm })

          ForEach(this.replies, (reply: Reply) => {
            ReplyCard({ reply: reply })
              .padding({ horizontal: AppTokens.Spacing.lg, vertical: AppTokens.Spacing.sm })
          })
        }
      }
      .backgroundColor(AppTokens.Colors.background)
      .layoutWeight(1)

      BottomCommentBar({ commentText: this.commentText })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}

// Components
@Component
struct UpVoteArrow {
  color: ResourceColor;

  build() {
    Shape() {
      Path()
        .commands('M14 0 L28 14 L14 28 L0 14 Z')
        .fill(this.color)
    }
    .width(28)
    .height(28)
  }
}

@Component
struct AuthorInfo {
  author: Author;
  timestamp: string;

  build() {
    Row({ space: AppTokens.Spacing.sm }) {
      Stack() {
        Circle({ width: 28, height: 28 })
          .fill(this.author.avatarColor)
        Circle({ width: 10, height: 10 })
          .fill('#33000000')
      }

      Text(this.author.name)
        .fontSize(AppTokens.Typography.small.size)
        .fontWeight(FontWeight.Bold)
        .fontColor(this.author.avatarColor)

      Text(this.timestamp)
        .fontSize(AppTokens.Typography.small.size)
        .fontColor(AppTokens.Colors.outline)
    }
  }
}

@Component
struct InfoChip {
  text: string;

  build() {
    Text(this.text)
      .fontSize(AppTokens.Typography.small.size)
      .fontWeight(FontWeight.Bold)
      .fontColor(AppTokens.Colors.outline)
  }
}

@Component
struct PostCard {
  post: Post;
  voteState: number;
  onVote: (val: number) => void;

  build() {
    Row({ space: AppTokens.Spacing.md }) {
      // Vote Column
      Column({ space: AppTokens.Spacing.sm }) {
        Button() {
          UpVoteArrow({ color: this.voteState === 1 ? AppTokens.Colors.secondary : AppTokens.Colors.outline })
        }
        .onClick(() => {
          this.onVote(this.voteState === 1 ? 0 : 1);
        })

        Text(`${this.post.votes + this.voteState - 1}`)
          .fontSize(AppTokens.Typography.title.size)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.voteState !== 0 ? AppTokens.Colors.secondary : AppTokens.Colors.onSurface)

        Button() {
          UpVoteArrow({ color: this.voteState === -1 ? AppTokens.Colors.primary : AppTokens.Colors.outline })
            .rotate({ angle: 180 })
        }
        .onClick(() => {
          this.onVote(this.voteState === -1 ? 0 : -1);
        })
      }
      .width(60)

      // Content Column
      Column({ space: AppTokens.Spacing.sm }) {
        AuthorInfo({ author: this.post.author, timestamp: this.post.timestamp })

        Text(this.post.title)
          .fontSize(AppTokens.Typography.headline.size)
          .fontWeight(AppTokens.Typography.headline.weight)
          .fontColor(AppTokens.Colors.onSurface)

        Text(this.post.body)
          .fontSize(AppTokens.Typography.body.size)
          .fontColor(AppTokens.Colors.onSurface)
          .opacity(0.8)

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
    .backgroundColor(AppTokens.Colors.surface)
  }
}

@Component
struct ReplyCard {
  reply: Reply;

  build() {
    Row({ space: AppTokens.Spacing.md }) {
      // Accent Bar
      Column()
        .width(3)
        .height('100%')
        .backgroundColor(this.reply.author.avatarColor)
        .opacity(0.5)
        .borderRadius(1.5)

      Column({ space: AppTokens.Spacing.xs }) {
        AuthorInfo({ author: this.reply.author, timestamp: this.reply.timestamp })

        Text(this.reply.text)
          .fontSize(AppTokens.Typography.body.size)
          .fontColor(AppTokens.Colors.onSurface)
          .opacity(0.9)

        Row({ space: AppTokens.Spacing.md }) {
          InfoChip({ text: `${this.reply.votes} votes` })
          InfoChip({ text: 'Reply' })
        }
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
  }
}

@Component
struct TopAppBar {
  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      // Background
      Column()
        .width('100%')
        .height(60)
        .backgroundColor(AppTokens.Colors.surface)

      Row() {
        Button() {
          Shape() {
            Path()
              .commands('M0 12 L24 12 M0 12 L12 0 M0 12 L12 24')
              .stroke(AppTokens.Colors.primary)
              .strokeWidth(3)
          }
          .width(24)
          .height(24)
        }
        .width(50)
        .height(50)

        Blank()

        Text('r/jetpackcompose')
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
      .padding({ horizontal: AppTokens.Spacing.lg })
    }
  }
}

@Component
struct BottomCommentBar {
  @Link commentText: string;

  build() {
    Column() {
      Divider()
        .color(AppTokens.Colors.outline)
        .strokeWidth(1)
        .opacity(0.3)
        .margin({ horizontal: AppTokens.Spacing.lg })

      Row({ space: AppTokens.Spacing.md }) {
        Stack({ alignContent: Alignment.Start }) {
          Column()
            .width('100%')
            .height(52)
            .backgroundColor(AppTokens.Colors.surfaceVariant)
            .borderRadius(AppTokens.Shapes.large)

          if (this.commentText === '') {
            Text('Add a comment...')
              .fontSize(AppTokens.Typography.body.size)
              .fontColor(AppTokens.Colors.outline)
              .height(52)
              .padding({ horizontal: AppTokens.Spacing.lg })
              .textAlign(TextAlign.Start)
              .width('100%')
          }

          TextInput({ text: this.commentText, placeholder: '' })
            .fontSize(AppTokens.Typography.body.size)
            .fontColor(AppTokens.Colors.onSurface)
            .height(52)
            .padding({ horizontal: AppTokens.Spacing.lg })
            .backgroundColor(Color.Transparent)
            .onChange((value: string) => {
              this.commentText = value;
            })
        }
        .layoutWeight(1)

        Button('POST')
          .fontSize(AppTokens.Typography.label.size)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppTokens.Colors.onPrimary)
          .height(52)
          .padding({ horizontal: AppTokens.Spacing.lg })
          .backgroundColor(AppTokens.Colors.primary)
          .borderRadius(AppTokens.Shapes.large)
      }
      .width('100%')
      .padding({ horizontal: AppTokens.Spacing.lg, vertical: AppTokens.Spacing.md })
      .backgroundColor(AppTokens.Colors.surface)
    }
  }
}