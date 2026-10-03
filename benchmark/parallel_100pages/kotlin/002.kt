package com.example.singlefileui

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.foundation.BorderStroke
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.WindowInsets
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.heightIn
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.rememberScrollState
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.foundation.verticalScroll
import androidx.compose.material3.Button
import androidx.compose.material3.ButtonDefaults
import androidx.compose.material3.Card
import androidx.compose.material3.CardDefaults
import androidx.compose.material3.CenterAlignedTopAppBar
import androidx.compose.material3.Divider
import androidx.compose.material3.ExperimentalMaterial3Api
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.OutlinedTextField
import androidx.compose.material3.Scaffold
import androidx.compose.material3.Shapes
import androidx.compose.material3.Surface
import androidx.compose.material3.Text
import androidx.compose.material3.Typography
import androidx.compose.material3.lightColorScheme
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.text.TextStyle
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.Dp
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import androidx.core.view.WindowCompat
import androidx.core.view.WindowInsetsCompat
import androidx.core.view.WindowInsetsControllerCompat

private const val NAME = "003_AuthLogin_en"
private const val UI_TYPE = "Authentication Login"
private const val STYLE_THEME = "Minimal Monochrome"
private const val LANG = "en"
private const val BASELINE_SIZE = "1280x720"

object AppTokens {
    object Colors {
        val primary = Color(0xFF111827)
        val onPrimary = Color(0xFFFFFFFF)
        val secondary = Color(0xFF6B7280)
        val onSecondary = Color(0xFFFFFFFF)
        val tertiary = Color(0xFF2563EB)
        val onTertiary = Color(0xFFFFFFFF)
        val background = Color(0xFFF9FAFB)
        val onBackground = Color(0xFF0B1220)
        val surface = Color(0xFFFFFFFF)
        val onSurface = Color(0xFF111827)
        val surfaceVariant = Color(0xFFF3F4F6)
        val outline = Color(0xFFE5E7EB)
        val success = Color(0xFF16A34A)
        val warning = Color(0xFFF59E0B)
        val error = Color(0xFFDC2626)
    }
    object TypographyTokens {
        val display = TextStyle(fontSize = 22.sp, fontWeight = FontWeight.SemiBold, lineHeight = 28.sp, letterSpacing = 0.sp)
        val headline = TextStyle(fontSize = 16.sp, fontWeight = FontWeight.SemiBold, lineHeight = 22.sp, letterSpacing = 0.sp)
        val title = TextStyle(fontSize = 14.sp, fontWeight = FontWeight.Medium, lineHeight = 18.sp, letterSpacing = 0.sp)
        val body = TextStyle(fontSize = 12.sp, fontWeight = FontWeight.Normal, lineHeight = 16.sp, letterSpacing = 0.sp)
        val label = TextStyle(fontSize = 10.sp, fontWeight = FontWeight.Medium, lineHeight = 14.sp, letterSpacing = 0.sp)
    }
    object Shapes {
        val small = RoundedCornerShape(4.dp)
        val medium = RoundedCornerShape(8.dp)
        val large = RoundedCornerShape(12.dp)
    }
    object Spacing {
        val xs = 2.dp
        val sm = 4.dp
        val md = 6.dp
        val lg = 8.dp
        val xl = 12.dp
        val xxl = 16.dp
        val xxxl = 24.dp
    }
    data class ShadowSpec(val elevation: Dp, val radius: Dp, val dy: Dp, val opacity: Float)
    object ElevationMapping {
        val level1 = ShadowSpec(1.dp, 2.dp, 0.5.dp, 0.10f)
        val level2 = ShadowSpec(2.dp, 4.dp, 1.dp, 0.14f)
        val level3 = ShadowSpec(3.dp, 6.dp, 1.5.dp, 0.16f)
        val level4 = ShadowSpec(4.dp, 8.dp, 2.dp, 0.18f)
        val level5 = ShadowSpec(5.dp, 10.dp, 2.5.dp, 0.20f)
    }
}

private val AppColorScheme = lightColorScheme(
    primary = AppTokens.Colors.primary,
    onPrimary = AppTokens.Colors.onPrimary,
    secondary = AppTokens.Colors.secondary,
    onSecondary = AppTokens.Colors.onSecondary,
    tertiary = AppTokens.Colors.tertiary,
    onTertiary = AppTokens.Colors.onTertiary,
    background = AppTokens.Colors.background,
    onBackground = AppTokens.Colors.onBackground,
    surface = AppTokens.Colors.surface,
    onSurface = AppTokens.Colors.onSurface,
    surfaceVariant = AppTokens.Colors.surfaceVariant,
    outline = AppTokens.Colors.outline,
    error = AppTokens.Colors.error
)

private val AppTypography = Typography(
    displayLarge = AppTokens.TypographyTokens.display,
    headlineMedium = AppTokens.TypographyTokens.headline,
    titleMedium = AppTokens.TypographyTokens.title,
    bodyMedium = AppTokens.TypographyTokens.body,
    labelMedium = AppTokens.TypographyTokens.label
)

@Composable
fun AppTheme(content: @Composable () -> Unit) {
    MaterialTheme(
        colorScheme = AppColorScheme,
        typography = AppTypography,
        shapes = Shapes(
            extraSmall = AppTokens.Shapes.small,
            small = AppTokens.Shapes.small,
            medium = AppTokens.Shapes.medium,
            large = AppTokens.Shapes.large,
            extraLarge = AppTokens.Shapes.large
        ),
        content = content
    )
}

data class SocialItem(val label: String, val tint: Color)

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun RootScreen() {
    var email by remember { mutableStateOf("") }
    var password by remember { mutableStateOf("") }
    val socials = listOf(
        SocialItem("Continue with Apple", AppTokens.Colors.primary),
        SocialItem("Continue with Google", AppTokens.Colors.tertiary),
        SocialItem("Continue with GitHub", AppTokens.Colors.secondary)
    )
    Scaffold(
        contentWindowInsets = WindowInsets(0),
        topBar = {
            CenterAlignedTopAppBar(
                title = {
                    Text(
                        text = "Sign in",
                        style = MaterialTheme.typography.displayLarge,
                        color = MaterialTheme.colorScheme.onSurface
                    )
                }
            )
        },
        containerColor = MaterialTheme.colorScheme.background
    ) { padding ->
        Column(
            modifier = Modifier
                .fillMaxSize()
                .padding(padding)
                .padding(horizontal = AppTokens.Spacing.xl, vertical = AppTokens.Spacing.lg)
                .verticalScroll(rememberScrollState()),
            verticalArrangement = Arrangement.spacedBy(AppTokens.Spacing.lg),
            horizontalAlignment = Alignment.CenterHorizontally
        ) {
            Card(
                shape = AppTokens.Shapes.large,
                colors = CardDefaults.cardColors(containerColor = MaterialTheme.colorScheme.surface),
                elevation = CardDefaults.cardElevation(defaultElevation = AppTokens.ElevationMapping.level2.elevation),
                border = BorderStroke(1.dp, MaterialTheme.colorScheme.outline),
                modifier = Modifier.fillMaxWidth()
            ) {
                Column(
                    modifier = Modifier
                        .fillMaxWidth()
                        .padding(horizontal = AppTokens.Spacing.xl, vertical = AppTokens.Spacing.xl),
                    verticalArrangement = Arrangement.spacedBy(AppTokens.Spacing.lg),
                    horizontalAlignment = Alignment.Start
                ) {
                    Text(text = "Welcome back", style = MaterialTheme.typography.headlineMedium, color = MaterialTheme.colorScheme.onSurface)
                    Column(
                        modifier = Modifier.fillMaxWidth(),
                        verticalArrangement = Arrangement.spacedBy(AppTokens.Spacing.md),
                        horizontalAlignment = Alignment.Start
                    ) {
                        Text(text = "Email", style = MaterialTheme.typography.labelMedium, color = MaterialTheme.colorScheme.onSurface)
                        OutlinedTextField(
                            value = email,
                            onValueChange = { email = it },
                            singleLine = true,
                            textStyle = MaterialTheme.typography.bodyMedium,
                            modifier = Modifier
                                .fillMaxWidth()
                                .heightIn(min = 44.dp)
                        )
                        Text(text = "Password", style = MaterialTheme.typography.labelMedium, color = MaterialTheme.colorScheme.onSurface)
                        OutlinedTextField(
                            value = password,
                            onValueChange = { password = it },
                            singleLine = true,
                            textStyle = MaterialTheme.typography.bodyMedium,
                            modifier = Modifier
                                .fillMaxWidth()
                                .heightIn(min = 44.dp)
                        )
                        Row(
                            modifier = Modifier
                                .fillMaxWidth()
                                .padding(top = AppTokens.Spacing.sm),
                            horizontalArrangement = Arrangement.SpaceBetween,
                            verticalAlignment = Alignment.CenterVertically
                        ) {
                            Text(text = "Forgot password?", style = MaterialTheme.typography.labelMedium, color = MaterialTheme.colorScheme.tertiary)
                            Text(text = "Create account", style = MaterialTheme.typography.labelMedium, color = MaterialTheme.colorScheme.tertiary)
                        }
                    }
                    Button(
                        onClick = {},
                        colors = ButtonDefaults.buttonColors(containerColor = MaterialTheme.colorScheme.primary, contentColor = MaterialTheme.colorScheme.onPrimary),
                        shape = AppTokens.Shapes.medium,
                        modifier = Modifier
                            .fillMaxWidth()
                            .height(44.dp)
                    ) {
                        Text(text = "Sign in", style = MaterialTheme.typography.titleMedium)
                    }
                }
            }
            Row(
                modifier = Modifier
                    .fillMaxWidth()
                    .padding(horizontal = AppTokens.Spacing.xl),
                horizontalArrangement = Arrangement.Center,
                verticalAlignment = Alignment.CenterVertically
            ) {
                Divider(color = MaterialTheme.colorScheme.outline, thickness = 1.dp, modifier = Modifier.weight(1f))
                Spacer(modifier = Modifier.size(AppTokens.Spacing.md))
                Text(text = "Or continue with", style = MaterialTheme.typography.labelMedium, color = MaterialTheme.colorScheme.onSurface)
                Spacer(modifier = Modifier.size(AppTokens.Spacing.md))
                Divider(color = MaterialTheme.colorScheme.outline, thickness = 1.dp, modifier = Modifier.weight(1f))
            }
            Column(
                modifier = Modifier.fillMaxWidth(),
                verticalArrangement = Arrangement.spacedBy(AppTokens.Spacing.sm),
                horizontalAlignment = Alignment.CenterHorizontally
            ) {
                socials.forEach {
                    Button(
                        onClick = {},
                        colors = ButtonDefaults.buttonColors(containerColor = it.tint, contentColor = AppTokens.Colors.onPrimary),
                        shape = AppTokens.Shapes.medium,
                        modifier = Modifier
                            .fillMaxWidth()
                            .height(40.dp)
                    ) {
                        Text(text = it.label, style = MaterialTheme.typography.titleMedium)
                    }
                }
            }
            Row(
                modifier = Modifier
                    .fillMaxWidth()
                    .padding(vertical = AppTokens.Spacing.sm),
                horizontalArrangement = Arrangement.Center,
                verticalAlignment = Alignment.CenterVertically
            ) {
                Text(text = "By continuing you agree to the Terms and Privacy Policy", style = MaterialTheme.typography.labelMedium, color = MaterialTheme.colorScheme.secondary)
            }
            Spacer(modifier = Modifier.height(AppTokens.Spacing.xxl))
            Surface(
                color = MaterialTheme.colorScheme.surfaceVariant,
                shadowElevation = AppTokens.ElevationMapping.level1.elevation,
                tonalElevation = AppTokens.ElevationMapping.level1.elevation,
                shape = AppTokens.Shapes.large,
                modifier = Modifier.fillMaxWidth()
            ) {
                Row(
                    modifier = Modifier
                        .fillMaxWidth()
                        .padding(horizontal = AppTokens.Spacing.xl, vertical = AppTokens.Spacing.lg),
                    horizontalArrangement = Arrangement.SpaceBetween,
                    verticalAlignment = Alignment.CenterVertically
                ) {
                    Column(
                        verticalArrangement = Arrangement.spacedBy(AppTokens.Spacing.xs),
                        horizontalAlignment = Alignment.Start
                    ) {
                        Text(text = "Need help?", style = MaterialTheme.typography.titleMedium, color = MaterialTheme.colorScheme.onSurface)
                        Text(text = "Contact support@example.com", style = MaterialTheme.typography.bodyMedium, color = MaterialTheme.colorScheme.onSurface)
                    }
                    Button(
                        onClick = {},
                        colors = ButtonDefaults.buttonColors(containerColor = MaterialTheme.colorScheme.tertiary, contentColor = MaterialTheme.colorScheme.onTertiary),
                        shape = AppTokens.Shapes.medium,
                        modifier = Modifier.height(36.dp)
                    ) {
                        Text(text = "Support", style = MaterialTheme.typography.titleMedium)
                    }
                }
            }
        }
    }
}

class MainActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        WindowCompat.setDecorFitsSystemWindows(window, false)
        val controller = WindowInsetsControllerCompat(window, window.decorView)
        controller.systemBarsBehavior =
            WindowInsetsControllerCompat.BEHAVIOR_SHOW_TRANSIENT_BARS_BY_SWIPE
        controller.hide(WindowInsetsCompat.Type.navigationBars())

        setContent {
            AppTheme {
                Surface(color = MaterialTheme.colorScheme.background) {
                    RootScreen()
                }
            }
        }
    }
}

@Preview(showBackground = true, backgroundColor = 0xFFFFFFFF, widthDp = 360, heightDp = 640)
@Composable
fun PreviewRoot() {
    AppTheme {
        RootScreen()
    }
}