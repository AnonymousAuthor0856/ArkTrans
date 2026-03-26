package com.example.myapplication

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
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
import androidx.compose.material.icons.filled.Add
import androidx.compose.material.icons.filled.Check
import androidx.compose.material.icons.filled.CheckCircle
import androidx.compose.material.icons.filled.DateRange
import androidx.compose.material.icons.filled.Home
import androidx.compose.material.icons.filled.Lock
import androidx.compose.material.icons.filled.Notifications
import androidx.compose.material.icons.filled.Person
import androidx.compose.material.icons.filled.Settings
import androidx.compose.material3.Card
import androidx.compose.material3.CardDefaults
import androidx.compose.material3.Divider
import androidx.compose.material3.Icon
import androidx.compose.material3.IconButton
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Surface
import androidx.compose.material3.Switch
import androidx.compose.material3.SwitchDefaults
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.SideEffect
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.graphics.vector.ImageVector
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

        // Configuration for Immersive Mode (Hide System Bars)
        val windowInsetsController = WindowCompat.getInsetsController(window, window.decorView)
        windowInsetsController.systemBarsBehavior =
            WindowInsetsControllerCompat.BEHAVIOR_SHOW_TRANSIENT_BARS_BY_SWIPE

        // Hide both status bar and navigation bar
        windowInsetsController.hide(WindowInsetsCompat.Type.systemBars())

        setContent {
            // Re-apply immersive mode on recomposition ensures it stays hidden
            SideEffect {
                windowInsetsController.hide(WindowInsetsCompat.Type.systemBars())
            }

            MaterialTheme(
                colorScheme = MaterialTheme.colorScheme.copy(
                    background = Color.White,
                    surface = Color.White,
                    onBackground = Color.Black,
                    onSurface = Color.Black
                )
            ) {
                Surface(
                    modifier = Modifier.fillMaxSize(),
                    color = Color.White
                ) {
                    SecureKeyScreen()
                }
            }
        }
    }
}

// --- Domain Models ---
data class AccessPoint(
    val id: String,
    val name: String,
    val status: String,
    val isLocked: Boolean,
    val lastAccessed: String
)

// --- Composable: Main Screen ---
@Composable
fun SecureKeyScreen() {
    val scrollState = rememberScrollState()

    // Mock State
    var masterLockState by remember { mutableStateOf(true) }

    Column(
        modifier = Modifier
            .fillMaxSize()
            .padding(24.dp)
            .verticalScroll(scrollState),
        verticalArrangement = Arrangement.Top
    ) {
        // Top Header
        HeaderSection()

        Spacer(modifier = Modifier.height(40.dp))

        // Master Control Status
        MasterStatusCard(
            isLocked = masterLockState,
            onToggle = { masterLockState = !masterLockState }
        )

        Spacer(modifier = Modifier.height(32.dp))

        // Quick Access List
        Text(
            text = "My Access Points",
            style = MaterialTheme.typography.titleMedium,
            fontWeight = FontWeight.Bold,
            color = Color.DarkGray
        )

        Spacer(modifier = Modifier.height(16.dp))

        AccessPointList()

        Spacer(modifier = Modifier.height(32.dp))

        // Recent Activity / Visitor Log
        Text(
            text = "Recent Activity",
            style = MaterialTheme.typography.titleMedium,
            fontWeight = FontWeight.Bold,
            color = Color.DarkGray
        )
        Spacer(modifier = Modifier.height(16.dp))

        ActivityLogItem(time = "10:42 AM", event = "Main Gate unlocked", user = "You")
        ActivityLogItem(time = "09:15 AM", event = "Guest Entry Denied", user = "System")
        ActivityLogItem(time = "08:30 AM", event = "Garage Door opened", user = "Alice")
    }
}

// --- Composable: Header ---
@Composable
fun HeaderSection() {
    Row(
        modifier = Modifier.fillMaxWidth(),
        horizontalArrangement = Arrangement.SpaceBetween,
        verticalAlignment = Alignment.CenterVertically
    ) {
        Column {
            Text(
                text = "Welcome back,",
                style = MaterialTheme.typography.bodyMedium,
                color = Color.Gray
            )
            Text(
                text = "David Miller",
                style = MaterialTheme.typography.headlineSmall,
                fontWeight = FontWeight.ExtraBold
            )
        }

        Box(
            modifier = Modifier
                .size(48.dp)
                .clip(CircleShape)
                .background(Color(0xFFF5F5F5))
                .border(1.dp, Color(0xFFE0E0E0), CircleShape),
            contentAlignment = Alignment.Center
        ) {
            Icon(
                imageVector = Icons.Default.Person,
                contentDescription = "Profile",
                tint = Color.Black
            )
        }
    }
}

// --- Composable: Master Status Card ---
@Composable
fun MasterStatusCard(isLocked: Boolean, onToggle: () -> Unit) {
    val statusColor = if (isLocked) Color(0xFF212121) else Color(0xFF4CAF50)
    val statusText = if (isLocked) "SECURE" else "UNLOCKED"
    val subText = if (isLocked) "All perimeter doors are locked." else "Perimeter access is currently open."

    Card(
        shape = RoundedCornerShape(24.dp),
        colors = CardDefaults.cardColors(containerColor = Color(0xFFF8F8F8)),
        elevation = CardDefaults.cardElevation(defaultElevation = 0.dp),
        modifier = Modifier
            .fillMaxWidth()
            .border(1.dp, Color(0xFFEFEFEF), RoundedCornerShape(24.dp))
    ) {
        Column(
            modifier = Modifier
                .padding(24.dp)
                .fillMaxWidth(),
            horizontalAlignment = Alignment.CenterHorizontally
        ) {
            Box(
                modifier = Modifier
                    .size(80.dp)
                    .clip(CircleShape)
                    .background(Color.White)
                    .clickable { onToggle() }
                    .border(2.dp, statusColor.copy(alpha = 0.1f), CircleShape),
                contentAlignment = Alignment.Center
            ) {
                Icon(
                    imageVector = if (isLocked) Icons.Default.Lock else Icons.Default.CheckCircle,
                    contentDescription = "Status Icon",
                    tint = statusColor,
                    modifier = Modifier.size(36.dp)
                )
            }

            Spacer(modifier = Modifier.height(16.dp))

            Text(
                text = statusText,
                style = MaterialTheme.typography.titleLarge,
                fontWeight = FontWeight.Black,
                letterSpacing = 2.sp,
                color = statusColor
            )

            Spacer(modifier = Modifier.height(8.dp))

            Text(
                text = subText,
                style = MaterialTheme.typography.bodyMedium,
                color = Color.Gray
            )
        }
    }
}

// --- Composable: Access Points ---
@Composable
fun AccessPointList() {
    val accessPoints = listOf(
        AccessPoint("1", "Main Entrance", "Active", true, "2h ago"),
        AccessPoint("2", "Garage Door", "Active", false, "12m ago"),
        AccessPoint("3", "Server Room", "Restricted", true, "Yesterday")
    )

    Column(verticalArrangement = Arrangement.spacedBy(12.dp)) {
        accessPoints.forEach { point ->
            AccessPointRow(point)
        }
    }
}

@Composable
fun AccessPointRow(item: AccessPoint) {
    var checked by remember { mutableStateOf(!item.isLocked) }

    Row(
        modifier = Modifier
            .fillMaxWidth()
            .background(Color.White)
            .border(1.dp, Color(0xFFEEEEEE), RoundedCornerShape(16.dp))
            .padding(16.dp),
        verticalAlignment = Alignment.CenterVertically,
        horizontalArrangement = Arrangement.SpaceBetween
    ) {
        Row(verticalAlignment = Alignment.CenterVertically) {
            Box(
                modifier = Modifier
                    .size(40.dp)
                    .clip(RoundedCornerShape(10.dp))
                    .background(Color(0xFFFAFAFA)),
                contentAlignment = Alignment.Center
            ) {
                Icon(
                    imageVector = Icons.Default.Home, // Using generic Home icon for simplicity
                    contentDescription = null,
                    tint = Color.Black,
                    modifier = Modifier.size(20.dp)
                )
            }
            Spacer(modifier = Modifier.width(16.dp))
            Column {
                Text(
                    text = item.name,
                    style = MaterialTheme.typography.bodyLarge,
                    fontWeight = FontWeight.SemiBold
                )
                Text(
                    text = item.lastAccessed,
                    style = MaterialTheme.typography.labelSmall,
                    color = Color.LightGray
                )
            }
        }

        Switch(
            checked = checked,
            onCheckedChange = { checked = it },
            colors = SwitchDefaults.colors(
                checkedThumbColor = Color.White,
                checkedTrackColor = Color.Black,
                uncheckedThumbColor = Color.Gray,
                uncheckedTrackColor = Color(0xFFEEEEEE),
                uncheckedBorderColor = Color.Transparent
            )
        )
    }
}

// --- Composable: Activity Log ---
@Composable
fun ActivityLogItem(time: String, event: String, user: String) {
    Row(
        modifier = Modifier
            .fillMaxWidth()
            .padding(vertical = 12.dp),
        verticalAlignment = Alignment.CenterVertically
    ) {
        Text(
            text = time,
            style = MaterialTheme.typography.labelMedium,
            color = Color.Gray,
            modifier = Modifier.width(70.dp)
        )

        Divider(
            modifier = Modifier
                .height(20.dp)
                .width(1.dp),
            color = Color(0xFFEEEEEE)
        )

        Spacer(modifier = Modifier.width(16.dp))

        Column {
            Text(
                text = event,
                style = MaterialTheme.typography.bodyMedium,
                fontWeight = FontWeight.Medium
            )
            Text(
                text = "by $user",
                style = MaterialTheme.typography.labelSmall,
                color = Color.Gray
            )
        }
    }
}

// --- Composable: Bottom Navigation (Simplified visual representation) ---
// Not used in main scroll, but could be added if layout required fixed bottom bar.
// For this single-screen flow, we keep it clean without a nav bar as requested.

@Preview(showBackground = true)
@Composable
fun PreviewSecureKey() {
    MaterialTheme(
        colorScheme = MaterialTheme.colorScheme.copy(
            background = Color.White,
            surface = Color.White
        )
    ) {
        SecureKeyScreen()
    }
}