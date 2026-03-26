package com.example.myapplication

import android.app.Activity
import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.activity.enableEdgeToEdge
import androidx.compose.foundation.background
import androidx.compose.foundation.border
import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.layout.width
import androidx.compose.foundation.rememberScrollState
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.foundation.verticalScroll
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.Check
import androidx.compose.material.icons.filled.CheckCircle
import androidx.compose.material.icons.filled.DateRange
import androidx.compose.material.icons.filled.Face
import androidx.compose.material.icons.filled.Favorite
import androidx.compose.material.icons.filled.PlayArrow
import androidx.compose.material.icons.filled.Settings
import androidx.compose.material.icons.filled.Star
import androidx.compose.material3.Button
import androidx.compose.material3.ButtonDefaults
import androidx.compose.material3.HorizontalDivider
import androidx.compose.material3.Icon
import androidx.compose.material3.IconButton
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Surface
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.SideEffect
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.graphics.toArgb
import androidx.compose.ui.graphics.vector.ImageVector
import androidx.compose.ui.platform.LocalView
import androidx.compose.ui.text.font.FontStyle
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import androidx.core.view.WindowCompat
import androidx.core.view.WindowInsetsCompat
import androidx.core.view.WindowInsetsControllerCompat

class MainActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        enableEdgeToEdge() // Android 15+ style

        setContent {
            // Logic to hide system bars for full immersion
            HideSystemBars()

            MaterialTheme {
                HabitTrackerScreen()
            }
        }
    }
}

/**
 * Ensures the app is full screen (Immersive Sticky Mode).
 */
@Composable
fun HideSystemBars() {
    val view = LocalView.current
    if (!view.isInEditMode) {
        SideEffect {
            val window = (view.context as Activity).window
            window.statusBarColor = Color.Transparent.toArgb()
            window.navigationBarColor = Color.Transparent.toArgb()

            val insetsController = WindowCompat.getInsetsController(window, view)
            insetsController.hide(WindowInsetsCompat.Type.systemBars())
            insetsController.systemBarsBehavior =
                WindowInsetsControllerCompat.BEHAVIOR_SHOW_TRANSIENT_BARS_BY_SWIPE
        }
    }
}

// -----------------------------------------------------------------------------------
// UI Constants & Colors
// -----------------------------------------------------------------------------------

val PrimaryBlack = Color(0xFF121212)
val BackgroundWhite = Color(0xFFFFFFFF)
val SurfaceGray = Color(0xFFF5F5F5)
val TextSecondary = Color(0xFF757575)
val AccentGreen = Color(0xFF4CAF50) // For completion state

// -----------------------------------------------------------------------------------
// Main Screen
// -----------------------------------------------------------------------------------

@Composable
fun HabitTrackerScreen() {
    Surface(
        modifier = Modifier.fillMaxSize(),
        color = BackgroundWhite
    ) {
        Column(
            modifier = Modifier
                .fillMaxSize()
                .padding(24.dp)
                .verticalScroll(rememberScrollState()),
            horizontalAlignment = Alignment.CenterHorizontally
        ) {
            Spacer(modifier = Modifier.height(24.dp))

            // -- Top Bar --
            Row(
                modifier = Modifier.fillMaxWidth(),
                horizontalArrangement = Arrangement.SpaceBetween,
                verticalAlignment = Alignment.CenterVertically
            ) {
                Column {
                    Text(
                        text = "THURSDAY",
                        fontSize = 12.sp,
                        color = TextSecondary,
                        fontWeight = FontWeight.Bold,
                        letterSpacing = 1.sp
                    )
                    Text(
                        text = "Dec 04",
                        fontSize = 24.sp,
                        color = PrimaryBlack,
                        fontWeight = FontWeight.Black
                    )
                }
                IconButton(
                    onClick = { /* No op */ },
                    modifier = Modifier
                        .border(1.dp, SurfaceGray, CircleShape)
                        .size(40.dp)
                ) {
                    Icon(
                        imageVector = Icons.Default.Settings,
                        contentDescription = "Settings",
                        tint = PrimaryBlack
                    )
                }
            }

            Spacer(modifier = Modifier.height(32.dp))

            // -- Hero Stats Card --
            StatsCard()

            Spacer(modifier = Modifier.height(32.dp))

            Text(
                text = "TODAY'S GOALS",
                fontSize = 12.sp,
                fontWeight = FontWeight.Bold,
                color = TextSecondary,
                letterSpacing = 1.5.sp,
                modifier = Modifier.fillMaxWidth()
            )

            Spacer(modifier = Modifier.height(16.dp))

            // -- Habit List --
            // Using icons guaranteed to be in androidx.compose.material.icons.filled (Core)
            HabitItem(
                icon = Icons.Default.Face,
                title = "Morning Meditation",
                subtitle = "15 minutes mindfulness",
                isCompleted = true
            )

            HabitItem(
                icon = Icons.Default.PlayArrow,
                title = "Gym Session",
                subtitle = "Upper body workout",
                isCompleted = false
            )

            HabitItem(
                icon = Icons.Default.Star,
                title = "Learn Spanish",
                subtitle = "Daily lesson completed",
                isCompleted = false
            )

            HabitItem(
                icon = Icons.Default.Favorite,
                title = "Drink Water",
                subtitle = "2L target",
                isCompleted = false
            )

            Spacer(modifier = Modifier.height(24.dp))

            // -- Inspiration Section --
            Box(
                modifier = Modifier
                    .fillMaxWidth()
                    .background(SurfaceGray, RoundedCornerShape(16.dp))
                    .padding(20.dp)
            ) {
                Column {
                    Icon(
                        imageVector = Icons.Default.CheckCircle,
                        contentDescription = null,
                        tint = TextSecondary,
                        modifier = Modifier.size(20.dp)
                    )
                    Spacer(modifier = Modifier.height(12.dp))
                    Text(
                        text = "Small steps every day add up to big results over time.",
                        fontSize = 14.sp,
                        color = PrimaryBlack,
                        fontStyle = FontStyle.Italic,
                        lineHeight = 20.sp
                    )
                }
            }

            Spacer(modifier = Modifier.height(48.dp))
        }
    }
}

// -----------------------------------------------------------------------------------
// Components
// -----------------------------------------------------------------------------------

@Composable
fun StatsCard() {
    Row(
        modifier = Modifier
            .fillMaxWidth()
            .height(140.dp)
            .background(PrimaryBlack, RoundedCornerShape(24.dp))
            .padding(24.dp),
        horizontalArrangement = Arrangement.SpaceBetween,
        verticalAlignment = Alignment.CenterVertically
    ) {
        Column(
            verticalArrangement = Arrangement.Center,
            modifier = Modifier.fillMaxSize()
        ) {
            Text(
                text = "Overall Progress",
                color = Color.White.copy(alpha = 0.7f),
                fontSize = 14.sp
            )
            Spacer(modifier = Modifier.height(8.dp))
            Text(
                text = "85%",
                color = Color.White,
                fontSize = 48.sp,
                fontWeight = FontWeight.Bold
            )
            Spacer(modifier = Modifier.height(4.dp))
            Row(verticalAlignment = Alignment.CenterVertically) {
                Icon(
                    imageVector = Icons.Default.Star,
                    contentDescription = null,
                    tint = Color(0xFFFFD700), // Gold
                    modifier = Modifier.size(16.dp)
                )
                Spacer(modifier = Modifier.width(4.dp))
                Text(
                    text = "12 Day Streak!",
                    color = Color.White,
                    fontSize = 14.sp,
                    fontWeight = FontWeight.Medium
                )
            }
        }
    }
}

@Composable
fun HabitItem(
    icon: ImageVector,
    title: String,
    subtitle: String,
    isCompleted: Boolean
) {
    // Local state for the checkbox effect (just visual in this pure UI demo)
    val checked = remember { mutableStateOf(isCompleted) }

    Row(
        modifier = Modifier
            .fillMaxWidth()
            .padding(vertical = 8.dp)
            .background(Color.White, RoundedCornerShape(16.dp))
            .border(1.dp, SurfaceGray, RoundedCornerShape(16.dp))
            .clickable { checked.value = !checked.value }
            .padding(16.dp),
        verticalAlignment = Alignment.CenterVertically
    ) {
        // Icon Box
        Box(
            modifier = Modifier
                .size(48.dp)
                .background(SurfaceGray, CircleShape),
            contentAlignment = Alignment.Center
        ) {
            Icon(
                imageVector = icon,
                contentDescription = null,
                tint = PrimaryBlack,
                modifier = Modifier.size(24.dp)
            )
        }

        Spacer(modifier = Modifier.width(16.dp))

        // Text Info
        Column(modifier = Modifier.weight(1f)) {
            Text(
                text = title,
                fontSize = 16.sp,
                fontWeight = FontWeight.Bold,
                color = if (checked.value) TextSecondary else PrimaryBlack,
                style = if (checked.value)
                    MaterialTheme.typography.bodyLarge.copy(textDecoration = androidx.compose.ui.text.style.TextDecoration.LineThrough)
                else MaterialTheme.typography.bodyLarge
            )
            Spacer(modifier = Modifier.height(2.dp))
            Text(
                text = subtitle,
                fontSize = 12.sp,
                color = TextSecondary
            )
        }

        Spacer(modifier = Modifier.width(8.dp))

        // Checkbox Button
        Box(
            modifier = Modifier
                .size(32.dp)
                .background(
                    if (checked.value) AccentGreen else Color.Transparent,
                    CircleShape
                )
                .border(
                    2.dp,
                    if (checked.value) AccentGreen else SurfaceGray,
                    CircleShape
                ),
            contentAlignment = Alignment.Center
        ) {
            if (checked.value) {
                Icon(
                    imageVector = Icons.Default.Check,
                    contentDescription = "Done",
                    tint = Color.White,
                    modifier = Modifier.size(18.dp)
                )
            }
        }
    }
}

@Preview(showBackground = true, showSystemUi = true)
@Composable
fun PreviewHabitTracker() {
    MaterialTheme {
        HabitTrackerScreen()
    }
}