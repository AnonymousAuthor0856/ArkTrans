package com.example.singlefileui

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.foundation.background
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.width
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.Button
import androidx.compose.material3.ButtonDefaults
import androidx.compose.material3.Card
import androidx.compose.material3.CardDefaults
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Scaffold
import androidx.compose.material3.Shapes
import androidx.compose.material3.Surface
import androidx.compose.material3.Text
import androidx.compose.material3.TextField
import androidx.compose.material3.TextFieldDefaults
import androidx.compose.material3.Typography
import androidx.compose.material3.lightColorScheme
import androidx.compose.runtime.Composable
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.shadow
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

private const val NAME = "059*AfterSale*en"
private const val UI_TYPE = "ECommerce"
private const val STYLE_THEME = "Clay Morph"
private const val LANG = "en"
private const val BASELINE_SIZE = "720x1280"

object AppTokens {
    object Colors {
        val primary = Color(0xFF8E6BF2)
        val secondary = Color(0xFFD3C1FF)
        val tertiary = Color(0xFFB39DDB)
        val background = Color(0xFFF5F3FF)
        val surface = Color(0xFFFFFFFF)
        val surfaceVariant = Color(0xFFECE6F8)
        val outline = Color(0xFFD1C4E9)
        val success = Color(0xFF4CAF50)
        val warning = Color(0xFFFFB300)
        val error = Color(0xFFE53935)
        val onPrimary = Color(0xFFFFFFFF)
        val onSecondary = Color(0xFF2E1A47)
        val onBackground = Color(0xFF2E1A47)
        val onSurface = Color(0xFF2E1A47)
    }
    object TypographyTokens {
        val display = TextStyle(fontSize = 28.sp, fontWeight = FontWeight.Bold)
        val title = TextStyle(fontSize = 18.sp, fontWeight = FontWeight.Medium)
        val body = TextStyle(fontSize = 14.sp, fontWeight = FontWeight.Normal)
        val label = TextStyle(fontSize = 12.sp, fontWeight = FontWeight.Medium)
    }
    object Shapes {
        val small = RoundedCornerShape(8.dp)
        val medium = RoundedCornerShape(14.dp)
        val large = RoundedCornerShape(20.dp)
    }
    object Spacing {
        val sm = 6.dp
        val md = 10.dp
        val lg = 16.dp
        val xl = 24.dp
    }
    data class ShadowSpec(val elevation: Dp, val radius: Dp, val dy: Dp, val opacity: Float)
    object ElevationMapping {
        val level1 = ShadowSpec(4.dp, 8.dp, 2.dp, 0.18f)
        val level2 = ShadowSpec(8.dp, 12.dp, 4.dp, 0.22f)
        val level3 = ShadowSpec(12.dp, 20.dp, 8.dp, 0.26f)
    }
}

private val AppColorScheme = lightColorScheme(
    primary = AppTokens.Colors.primary,
    onPrimary = AppTokens.Colors.onPrimary,
    secondary = AppTokens.Colors.secondary,
    onSecondary = AppTokens.Colors.onSecondary,
    background = AppTokens.Colors.background,
    onBackground = AppTokens.Colors.onBackground,
    surface = AppTokens.Colors.surface,
    onSurface = AppTokens.Colors.onSurface,
    surfaceVariant = AppTokens.Colors.surfaceVariant,
    outline = AppTokens.Colors.outline
)

private val AppTypography = Typography(
    displayLarge = AppTokens.TypographyTokens.display,
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
            small = AppTokens.Shapes.small,
            medium = AppTokens.Shapes.medium,
            large = AppTokens.Shapes.large
        ),
        content = content
    )
}

@Composable
fun RootScreen() {
    val orderId = remember { mutableStateOf("") }
    val issue = remember { mutableStateOf("") }
    val submitted = remember { mutableStateOf(false) }
    Scaffold(
        contentWindowInsets = androidx.compose.foundation.layout.WindowInsets(0),
        containerColor = AppTokens.Colors.background
    ) { pad ->
        Column(
            modifier = Modifier
                .fillMaxSize()
                .padding(pad)
                .padding(AppTokens.Spacing.lg),
            verticalArrangement = Arrangement.spacedBy(AppTokens.Spacing.lg)
        ) {
            Text("After-Sale Service", style = AppTokens.TypographyTokens.display, color = AppTokens.Colors.onBackground)
            Card(
                shape = AppTokens.Shapes.large,
                colors = CardDefaults.cardColors(containerColor = AppTokens.Colors.surface),
                elevation = CardDefaults.cardElevation(AppTokens.ElevationMapping.level2.elevation),
                modifier = Modifier
                    .fillMaxWidth()
                    .shadow(
                        elevation = AppTokens.ElevationMapping.level2.elevation,
                        spotColor = AppTokens.Colors.secondary,
                        ambientColor = AppTokens.Colors.outline
                    )
            ) {
                Column(
                    modifier = Modifier
                        .fillMaxWidth()
                        .padding(AppTokens.Spacing.lg),
                    verticalArrangement = Arrangement.spacedBy(AppTokens.Spacing.md)
                ) {
                    Text("Order ID", style = AppTokens.TypographyTokens.title, color = AppTokens.Colors.onSurface)
                    TextField(
                        value = orderId.value,
                        onValueChange = { orderId.value = it },
                        modifier = Modifier.fillMaxWidth(),
                        placeholder = { Text("Enter order number", color = AppTokens.Colors.onSurface.copy(alpha = 0.5f)) },
                        colors = TextFieldDefaults.colors(
                            focusedContainerColor = AppTokens.Colors.surfaceVariant,
                            unfocusedContainerColor = AppTokens.Colors.surfaceVariant,
                            focusedIndicatorColor = AppTokens.Colors.primary,
                            unfocusedIndicatorColor = AppTokens.Colors.outline
                        ),
                        shape = AppTokens.Shapes.medium
                    )
                    Text("Issue Description", style = AppTokens.TypographyTokens.title, color = AppTokens.Colors.onSurface)
                    TextField(
                        value = issue.value,
                        onValueChange = { issue.value = it },
                        modifier = Modifier.fillMaxWidth().height(120.dp),
                        placeholder = { Text("Describe your issue", color = AppTokens.Colors.onSurface.copy(alpha = 0.5f)) },
                        colors = TextFieldDefaults.colors(
                            focusedContainerColor = AppTokens.Colors.surfaceVariant,
                            unfocusedContainerColor = AppTokens.Colors.surfaceVariant,
                            focusedIndicatorColor = AppTokens.Colors.primary,
                            unfocusedIndicatorColor = AppTokens.Colors.outline
                        ),
                        shape = AppTokens.Shapes.medium
                    )
                }
            }
            Button(
                onClick = { submitted.value = true },
                colors = ButtonDefaults.buttonColors(containerColor = AppTokens.Colors.primary, contentColor = AppTokens.Colors.onPrimary),
                shape = AppTokens.Shapes.large,
                modifier = Modifier.fillMaxWidth().height(56.dp)
            ) {
                Text("Submit Request", style = AppTokens.TypographyTokens.title)
            }
            if (submitted.value) {
                Box(
                    modifier = Modifier
                        .fillMaxWidth()
                        .background(AppTokens.Colors.success.copy(alpha = 0.15f), AppTokens.Shapes.medium)
                        .padding(AppTokens.Spacing.lg),
                    contentAlignment = Alignment.Center
                ) {
                    Text("Request submitted successfully!", color = AppTokens.Colors.success, style = AppTokens.TypographyTokens.body)
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
        controller.systemBarsBehavior = WindowInsetsControllerCompat.BEHAVIOR_SHOW_TRANSIENT_BARS_BY_SWIPE
        controller.hide(WindowInsetsCompat.Type.systemBars())
        setContent {
            AppTheme {
                Surface(color = MaterialTheme.colorScheme.background) {
                    RootScreen()
                }
            }
        }
    }
    override fun onWindowFocusChanged(hasFocus: Boolean) {
        super.onWindowFocusChanged(hasFocus)
        if (hasFocus) {
            val controller = WindowInsetsControllerCompat(window, window.decorView)
            controller.systemBarsBehavior = WindowInsetsControllerCompat.BEHAVIOR_SHOW_TRANSIENT_BARS_BY_SWIPE
            controller.hide(WindowInsetsCompat.Type.systemBars())
        }
    }
}

@Preview(showBackground = true, backgroundColor = 0xFFF5F3FF)
@Composable
fun PreviewRoot() {
    AppTheme {
        RootScreen()
    }
}
